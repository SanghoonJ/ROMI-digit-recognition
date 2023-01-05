function [labelCord, label] = Func_DigitDetector(I, algObj, point)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Make Binary Mask
    [BinaryMask] = Func_PreProcessing(I);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize the blob analysis System object(TM).
    blobAnalyzer = vision.BlobAnalysis('MaximumCount',500);
    
    % Run the blob analyzer to find connected components and their statistics.
    [Area,centroids,BBox] = step(blobAnalyzer,BinaryMask);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ROI = zeros(size(BBox,1), size(BBox,2));
    areaConstraint = Area > 150;
    
    % Keep regions that meet the area constraint.
    roi = double(BBox(areaConstraint, :));

    % Compute the aspect ratio.
    width  = roi(:,3);
    height = roi(:,4);
    aspectRatio = width ./ height;
    
    % An aspect ratio between 0.25 and 1 is typical for individual characters
    % as they are usually not very short and wide or very tall and skinny.
    roi = roi( aspectRatio > 0.3 & aspectRatio < 0.8 ,:);
    
    ROI_N = size(roi,1);
    ROI(1:ROI_N,:) = roi;
    if(point<=ROI_N)
        labelCord = ROI(point,:);
        %     s = regionprops(BinaryMask, 'BoundingBox' );
        %     labelCord = s(point).BoundingBox;
        %     labelCord = labelCord;
        %     labelCord(1)= round(labelCord(1));
        %     labelCord(2)= round(labelCord(2));
        %     labelCord(3)= round(labelCord(3));
        %     labelCord(4)= round(labelCord(4));
        
        % ML model
        %mdl = loadLearnerForCoder('originalMNIST.mat'); 
        BW_crop = imcrop(BinaryMask, labelCord);
        
        % Pre-processing for ML
        Img_bin = imresize(BW_crop, [28 28]);
        Img_bin = imcomplement(Img_bin);    
        
        cellSize=[4 4];
        features = single(zeros(1, 1296));
        features(:) = extractHOGFeatures(Img_bin,'CellSize',cellSize);
        
        Mdl = loadLearnerForCoder('SVMUser');
        label = predict(Mdl,features);
    else
       labelCord = [0 0 0 0];
       label = 'None';
    end
%     [y,score]= predict(mdl,features);
%     if (y==0)
%         label = 'D0';
%     elseif (y==1)
%         label = 'D1';
%     elseif (y==2)
%         label = 'D2';
%     elseif (y==3)
%         label = 'D3';
%     elseif (y==4)
%         label = 'D4';
%     elseif (y==5)
%         label = 'D5';
%     elseif (y==6)
%         label = 'D6';
%     elseif (y==7)
%         label = 'D7';
%     elseif (y==8)
%         label = 'D8';
%     elseif (y==9)
%         label = 'D9';
%     end

end