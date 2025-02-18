classdef ImageColourisationApp < matlab.apps.AppBase
    
    % Properties (UI components)
    properties (Access = public)
        % General components
        UIFigure       matlab.ui.Figure
        GridLayout     matlab.ui.container.GridLayout
        ControlLayout  matlab.ui.container.GridLayout
        ImOrig         matlab.ui.control.Image
        ImGrey         matlab.ui.control.Image
        ImOG           matlab.ui.control.Image
        ImRec          matlab.ui.control.Image
        BtnGen         matlab.ui.control.Button
        BtnInput       matlab.ui.control.Button
        BtnOutput      matlab.ui.control.Button
        % Colour generation components
        SelectPanel    matlab.ui.container.Panel  % Selection area
        SelectLayout   matlab.ui.container.GridLayout % Panel layout
        BtnGroup       matlab.ui.container.ButtonGroup  % Radio button group
        BtnUniformed   matlab.ui.control.RadioButton  % Uniformed radio button
        BtnRandom      matlab.ui.control.RadioButton  % Random radio button
        BtnDraw        matlab.ui.control.RadioButton
        BtnAct         matlab.ui.control.Button  % Draw radio button
        TextField      
        

        % Popup window components
        PopFigure      matlab.ui.Figure
        PopAxes 


    end

    % Data Storage
    properties (Access = private)
        filename = ""; % Filename of images
        roi = []; % Region of Interests
        img = []; % Image data
        gImg = []; % greyscale image data

        colourPcnt = 0; % Initial colour percentage
        sampleType = "Uniformed" 
    end

    % Callback Functions
    methods (Access = private)

        % Button: Select and load an image
        function btnInputPushFcn(app, ~)
            [file, path] = uigetfile('*.*', 'Select an image');
            if isequal(file, 0)
                disp('User canceled file selection.');
                return;
            end
            app.filename = fullfile(path, file);

            % Clear all images in uiimage
            app.ImOG.ImageSource = "";
            app.ImRec.ImageSource = "";
            
            % Display the original image
            app.ImOrig.ImageSource = app.filename;
            app.img = imread(app.filename);
            % Generate and display grayscale image
            app.gImg = genGreyImg(app.filename);
            app.ImGrey.ImageSource = app.gImg;

        end

        % Button: Draw a region with colour
        function btnDrawPushFcn(app, ~)
            if isempty(app.filename)
                disp('Please select an image');
                return;
            end
            % Create popup window
            app.PopFigure = uifigure('Name', 'Draw on Image', 'Position', [500, 300, 800, 600]);
            grid = uigridlayout(app.PopFigure, [2, 1]);
            grid.RowHeight = {'fit', '1x', 'fit'};

            % Create the label
            uilabel(grid, 'Text', 'Please draw on the image using your mouse', 'FontSize', 12, ...
                'HorizontalAlignment', 'center');

            % Create UI axes for displaying the image
            imgPanel = uipanel(grid);
            app.PopAxes = uiaxes(imgPanel);
            app.PopAxes.Position = [10, 10, 500, 500];

            % Button Panel
            buttonPanel = uigridlayout(grid, [1, 1]);
            % Button: Confirm and Close
            uibutton(buttonPanel, 'Text', 'Confirm and Close', 'ButtonPushedFcn', @(~, ~) app.confirmPopDrawing());

            % Load and display the image
            app.img = imread(app.filename);
            imshow(app.img, 'Parent', app.PopAxes);
            hold(app.PopAxes, 'on');

            app.roi = drawRegion(app.PopAxes, app.img);
        end

        % Confirm drawing, store ROI, and close popup
        function confirmPopDrawing(app)
            close(app.PopFigure);
            combinedImg = combineMaskedImg(app.img, app.gImg, app.roi);
            app.ImOG.ImageSource = combinedImg;
        end

        % Radio button call back function
        function radioBtnFcn(app, event)
            selectedText = event.NewValue.Text;
            switch selectedText
                case "Uniformed"
                    app.TextField.Editable = 'on';
                    app.TextField.Enable = 'on';
                    app.sampleType = "Uniformed";
                    app.BtnAct.Text = "Generate";
                    
                case "Random"
                    app.TextField.Editable = 'on';
                    app.TextField.Enable = 'on';
                    app.sampleType = "Random";
                    app.BtnAct.Text = "Generate";

                case "Draw"
                    app.TextField.Editable = 'off';
                    app.TextField.Enable = 'off';
                    app.sampleType = "Draw";
                    app.BtnAct.Text = 'Draw';
            end

            disp(app.sampleType)
            
        end

        function textFieldFcn(app, event)
            app.colourPcnt = event.Value;
        end

        function btnGenROI(app)
            app.sampleType
            switch app.sampleType
                case "Uniformed"
                    app.roi = genUnif(app.img, app.colourPcnt);
                    combinedImg = combineMaskedImg(app.img, app.gImg, app.roi);
                    app.ImOG.ImageSource = combinedImg;
                case "Random"
                    app.roi = genRand(app.img, app.colourPcnt);
                    combinedImg = combineMaskedImg(app.img, app.gImg, app.roi);
                    app.ImOG.ImageSource = combinedImg;
                case "Draw"
                    btnDrawPushFcn(app)
            end          
        end

        %% TO DO Part
        % TO DO: Button: Perform colourisation 
        function btnGenPushFcn(app, ~)
            ...
        end

        % TO DO: Button: Save the processed image
        function btnOutputPushFcn(app, ~)
            ...
        end
        %%


    end




    % App Constructor
    methods (Access = public)

        function app = ImageColourisationApp()
            % Create main UI figure
            app.UIFigure = uifigure('Name', 'Image Colourisation', 'Position', [400, 240, 1000, 600]);

            % Create grid layout
            app.GridLayout = uigridlayout(app.UIFigure, [2, 3]);

            % right-side button panel
            app.ControlLayout = uigridlayout(app.GridLayout, [4, 1]);
            app.ControlLayout.Layout.Row = [1, 2];
            app.ControlLayout.Layout.Column = 3;

            % Create image windows
            app.ImOrig = uiimage(app.GridLayout);
            app.ImGrey = uiimage(app.GridLayout);
            app.ImOG = uiimage(app.GridLayout);
            app.ImRec = uiimage(app.GridLayout);

            % Set image window layout
            app.ImOrig.Layout.Row = 1;
            app.ImOrig.Layout.Column = 1;

            app.ImGrey.Layout.Row = 1;
            app.ImGrey.Layout.Column = 2;

            app.ImOG.Layout.Row = 2;
            app.ImOG.Layout.Column = 1;

            app.ImRec.Layout.Row = 2;
            app.ImRec.Layout.Column = 2;

            % Create buttons
            app.BtnInput = uibutton(app.ControlLayout, 'Text', 'Input an image', ...
                'ButtonPushedFcn', @(~, ~) app.btnInputPushFcn());
                 
            % 
            app.SelectPanel = uipanel(app.ControlLayout, 'Title', 'Select Colouring Type');
            app.SelectLayout = uigridlayout(app.SelectPanel, [2, 2]);
            app.BtnGroup = uibuttongroup("Parent", app.SelectLayout, 'SelectionChangedFcn', @(~, event) app.radioBtnFcn(event));
            app.BtnGroup.Layout.Row = 1;
            app.BtnGroup.Layout.Column = [1, 2];

            app.BtnUniformed = uiradiobutton(app.BtnGroup, "Text", 'Uniformed', 'Position', [10, 10, 91, 22]);
            app.BtnRandom = uiradiobutton(app.BtnGroup, "Text", 'Random', 'Position', [101, 10, 91, 22]);
            app.BtnDraw = uiradiobutton(app.BtnGroup, "Text", 'Draw', 'Position', [192, 10, 91, 22]);

            app.TextField = uieditfield(app.SelectLayout, 'numeric', 'Placeholder', ...
                '%', 'AllowEmpty','off', 'Limits', [0, 100], 'RoundFractionalValues','on', ...
                'ValueChangedFcn', @(~, event) app.textFieldFcn(event));

            app.BtnAct = uibutton(app.SelectLayout, 'Text', 'Generate', 'ButtonPushedFcn', @(~, ~) app.btnGenROI());


            app.BtnGen = uibutton(app.ControlLayout, 'Text', 'Perform Colourisation', ...
                'ButtonPushedFcn', @(~, ~) app.btnGenPushFcn());

            app.BtnOutput = uibutton(app.ControlLayout, 'Text', 'Save Image', ...
                'ButtonPushedFcn', @(~, ~) app.btnOutputPushFcn());

            % Set button layout
            app.BtnInput.Layout.Row = 1;
            app.BtnGen.Layout.Row = 3;
            app.BtnOutput.Layout.Row = 4;
        end
    end
end
