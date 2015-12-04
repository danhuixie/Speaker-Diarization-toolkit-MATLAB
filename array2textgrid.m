function a = array2textgrid (filename,xmin,xmax,Text)
% Function array2textgrid generates a textgrid file from an array of
% interval starts, interval ends and interval labels. Function returns 1 if
% file generated sucessfully
% This type of TextGrid file were generated by Parthe Pandit as part of
% annotation for the Speaker Diarization Project
%
% Usage:
%
% array2textgrid (filename,xmin,xmax,text)
% Input arguments:
% filename - name of file to be generated
% xmin - array of interval start points in seconds
% xmax - array of interval end points in seconds
% text - cell array of interval labels
%
% Elements of xmin and xmax are in a way redundant. But xmin(i) = xmax(i-1)
% for i = 2:length(xmin)
% xmin(1) = 0 (start fo audio)
% xmax(end) = length of audio

    if ((length(xmin) == length(xmax)) && (length(xmax) == length(Text)) && (xmin(1) == 0) && isequal(xmin(2:end) , xmax(1:end - 1))) % check error
        a = 1;

        filename = [filename '.TextGrid'];
        file_leng = xmax(end);
        n_intervals = length(xmax);

        myformat = '%s\n';

        % Print initial crap
        init_string = ['File type = "ooTextFile"' char(10) 'Object class = "TextGrid"' char(10) '' char(10) 'xmin = 0 ' char(10) 'xmax = ' num2str(file_leng) '' char(10) ''];    
        next_init_string = ['tiers? <exists> ' char(10) 'size = 1 ' char(10) 'item []: ' char(10) '    item [1]:' char(10) '        class = "IntervalTier" ' char(10) '        name = "Mary" ' char(10) '        xmin = 0 ' char(10) '        xmax = ' num2str(file_leng) ' ' char(10) '        intervals: size = ' num2str(n_intervals)];

        % print statement
        fid = fopen(filename,'w');
        fprintf(fid,myformat,[init_string next_init_string]);
        fclose(fid);

        for seg_ind = 1:length(xmax)
            seg_text = Text{seg_ind}; % text is stored as cell

            string1 = ['        intervals [' num2str(seg_ind) ']:'];
            string2 = ['            xmin = ' num2str(xmin(seg_ind)) ' '];
            string3 = ['            xmax = ' num2str(xmax(seg_ind)) ' '];
            string4 = ['            text = "' seg_text '" '];

            % print statement
            fid = fopen(filename,'a');
            fprintf(fid,myformat,string1);
            fprintf(fid,myformat,string2);
            fprintf(fid,myformat,string3);
            fprintf(fid,myformat,string4);
            fclose(fid);
        end

    else
        a = 0;
    end

end