function color_RGB = pl_color(color)
%function color_RGB = pl_color(color)
%
%   Returns color

c_case = 1;

if c_case == 1
    
    switch (color)
        case '1-harm'
            color_RGB = 'black';
        case 'n-harm'
            color_RGB = 'black';
        case 'stoch'
            color_RGB = 'black';
        case 'cyl'
            color_RGB = 'black';
        case '1-harm_fit'
            color_RGB = '0.8000    0.3961    0.1255';
        case 'n-harm_fit'
            color_RGB = '0.8000    0.3961    0.1255';
        case 'stoch_fit'
            color_RGB = '0.8000    0.3961    0.1255';
        case 'cyl_fit'
            color_RGB = '0.8000    0.3961    0.1255';
        case 'MC'
            color_RGB = '[0.8000    0.3961    0.1255]';
        case 'extra'
            color_RGB = '[0.4235    0.4039    0.6941]';
        case 'line'
            color_RGB = '[0.5 0.5 0.5]';            
            
    end
    
end


if c_case == 2
    %[0.8588    0.5843    0.0039]
    %[0.8510    0.3255    0.0980]
    
end

end

