%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File: main.m
%%% Description: 
%%% Author: Guillaume Lemaitre - Mojdeh Rastgoo 
%%% LE2I - ViCOROB
%%% Date: 10 February 2014
%%% Version: 0.1
%%% Copyright (c) 2014 Guillaume Lemaitre
%%% http://le2i.cnrs.fr/ - http://vicorob.udg.es/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Paths

path_gt = '..\images\gt\';
path_seg = '..\images\seg\';

%% Evaluation for the different images

% Get the content of the original folder
content_list = dir( [ path_gt, 'expert_1/' ] );

% Annotate each file
for file = 1 : length( content_list )
    % Exclude the directories
    if ( content_list( file ).isdir ~= 1 )
        % Check the if it is a jpg file
        info = imfinfo( fullfile( [ path_gt, 'expert_1/' ], content_list( file ).name ) );
        if ( strcmp(info.Format, 'png') )
            % Current file to evaluate
            filename = content_list( file ).name;
            
            % Expert 1
            gt_exp_1 = im2bw( imread( [ path_gt, 'expert_1/', filename ] ) );

            % Expert 2
            gt_exp_2 = im2bw( imread( [ path_gt, 'expert_2/', filename ] ) );

            % Expert 3
            gt_exp_3 = im2bw( imread( [ path_gt, 'expert_3/', filename ] ) );

            % fusion
            %gt_fusion = im2bw( imread( [ path_gt, 'fusion/', filename ] ) );
            
            % Read the results of the fuzzy segmentation
            fuzzy_seg = imread( [ path_seg, 'fuzzy-c-means/', filename ] );

            % Make the evaluation for this image
            disp( [ 'Evaluation of ', filename, ' - Fuzzy C-Means vs. Expert 1:' ] );
            fuzzy_stat_vec_1 = mainEvaluation( fuzzy_seg, gt_exp_1 );
            pause;
            disp( [ 'Evaluation of ', filename, ' - Fuzzy C-Means vs. Expert 2:' ] );
            fuzzy_stat_vec_2 = mainEvaluation( fuzzy_seg, gt_exp_2 );
            pause;
            disp( [ 'Evaluation of ', filename, ' - Fuzzy C-Means vs. Expert 3:' ] );
            fuzzy_stat_vec_3 = mainEvaluation( fuzzy_seg, gt_exp_3 );
            pause;
            %disp( [ 'Evaluation of ', filename, ' - Fuzzy C-Means vs. Fusion:' ] );
            %fuzzy_stat_vec_fusion = mainEvaluation( fuzzy_seg, gt_fusion );
            %pause;
            
            % Read the results of the level-set segmentation
            levelset_seg = imread( [ path_seg, 'level-set/', filename ] );

            % Make the evaluation for this image
            disp( [ 'Evaluation of ', filename, ' - Level-Set Segmentation vs. Expert 1:' ] );
            levelset_vec_1 = mainEvaluation( levelset_seg, gt_exp_1 );
            pause;
            disp( [ 'Evaluation of ', filename, ' - Level-Set Segmentation vs. Expert 2:' ] );
            levelset_vec_2 = mainEvaluation( levelset_seg, gt_exp_2 );
            pause;
            disp( [ 'Evaluation of ', filename, ' - Level-Set Segmentation vs. Expert 3:' ] );
            levelset_vec_3 = mainEvaluation( levelset_seg, gt_exp_3 );
            pause;
%             disp( [ 'Evaluation of ', filename, ' - Level-Set Segmentation vs. Fusion:' ] );
%             levelset_vec_fusion = mainEvaluation( levelset_seg, gt_fusion );
%             pause;
            
             % Read the results of the fuzzy segmentation
            pdf_seg = imread( [ path_seg, 'pdf-based/', filename ] );

            % Make the evaluation for this image
            disp( [ 'Evaluation of ', filename, ' - PDF-based Segmentation vs. Expert 1:' ] );
            pdf_vec_1 = mainEvaluation( pdf_seg, gt_exp_1 );
            pause;
            disp( [ 'Evaluation of ', filename, ' - PDF-based Segmentation vs. Expert 2:' ] );
            pdf_vec_2 = mainEvaluation( pdf_seg, gt_exp_2 );
            pause;
            disp( [ 'Evaluation of ', filename, ' - PDF-based Segmentation vs. Expert 3:' ] );
            pdf_vec_3 = mainEvaluation( pdf_seg, gt_exp_3 );
            pause;
%             disp( [ 'Evaluation of ', filename, ' - PDF-based Segmentation vs. Fusion:' ] );
%             pdf_vec_fusion = mainEvaluation( pdf_seg, gt_fusion );
%             pause;
        end
    end
end

