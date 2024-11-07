function results = NPCR_and_UACI( img_a, img_b, need_display, largest_allowed_val )


%% 1. input_check 
[ height_a, width_a, depth_a ] = size( img_a );
[ height_b, width_b, depth_b ] = size( img_b );
if ( ( height_a ~= height_b ) ...
  || (  width_a ~=  width_b ) ...
  || (  depth_a ~=  depth_b ) )
    error( 'input images have to be of same dimensions' );
end
class_a = class( img_a );
class_b = class( img_b );
if ( ~strcmp( class_a, class_b) )
    error( 'input images have to be of same data type'); 
end

%% 2. measure preparations
if ( ~exist( 'largest_allowed_val', 'var') )
    switch  class_a 
        case 'uint16'
            largest_allowed_val = 65535;
        case 'uint8'
            largest_allowed_val = 255;
        case 'logical'
            largest_allowed_val = 2;
        otherwise
            largest_allowed_val = max ( max( img_a(:), img_b(:) ) );
    end
end
if ( ~exist( 'need_display', 'var' ) ) 
    need_display = 1;
end
img_a = double( img_a );
img_b = double( img_b );
num_of_pix = numel( img_a );

%% 3. NCPR score and p_value
results.npcr_score = sum( double( img_a(:) ~= img_b(:) ) ) / num_of_pix;
npcr_mu  = ( largest_allowed_val ) / ( largest_allowed_val+ 1 );
npcr_var =  ( ( largest_allowed_val) / ( largest_allowed_val+ 1 )^2 ) / num_of_pix;
results.npcr_pVal = normcdf( results.npcr_score, npcr_mu, sqrt( npcr_var ) );
results.npcr_dist = [ npcr_mu, npcr_var ];

%% 4. UACI score and p_value 
results.uaci_score = sum( abs( img_a(:) - img_b(:) ) ) / num_of_pix / largest_allowed_val; 
uaci_mu  = ( largest_allowed_val+2 ) / ( largest_allowed_val*3+3 );
uaci_var = ( ( largest_allowed_val+2 ) * ( largest_allowed_val^2 + 2*largest_allowed_val+ 3 ) /18 / ( largest_allowed_val+ 1 )^2 / largest_allowed_val) / num_of_pix;
p_vals = normcdf( results.uaci_score, uaci_mu, sqrt( uaci_var ) );
p_vals( p_vals > 0.5 ) = 1 - p_vals( p_vals > 0.5 );
results.uaci_pVal = 2 * p_vals;
results.uaci_dist = [ uaci_mu, uaci_var ];

%% 5. optional output
% Optional graphical output
if ( need_display ) 
    % NPCR pdf distribution
    [hist_npcr, val_npcr] = hist(results.npcr_score, [0:(1/num_of_pix):1]);
    figure;
    subplot(221);
    bar(val_npcr, hist_npcr / sum(hist_npcr));
    title('NCPR pdf');
    theoretical_hist_npcr = normcdf(val_npcr, results.npcr_dist(1), sqrt(results.npcr_dist(2))) ...
        - normcdf([0, val_npcr(1:end-1)], results.npcr_dist(1), sqrt(results.npcr_dist(2)));
    hold on, plot(val_npcr, theoretical_hist_npcr, 'r--', 'LineWidth', 2), xlim([results.npcr_dist(1) + 4 * sqrt(results.npcr_dist(2)) * [-1,1]])
    legend('sample distribution', 'theoretical distribution', 'Location', 'NorthEast'); axis square;

    % NPCR cdf distribution
    subplot(223);
    bar(val_npcr, cumsum(hist_npcr / sum(hist_npcr)));
    title('NCPR cdf');
    hold on, plot(val_npcr, cumsum(theoretical_hist_npcr), 'g--', 'LineWidth', 2), xlim([results.npcr_dist(1) + 4 * sqrt(results.npcr_dist(2)) * [-1,1]])
    legend('sample distribution', 'theoretical distribution', 'Location', 'southeast');  
    axis square;

    % UACI pdf distribution
    [hist_uaci, val_uaci] = hist(results.uaci_score, [0:(1/num_of_pix):1]);
    subplot(222);
    bar(val_uaci, hist_uaci / sum(hist_uaci));
    title('UACI pdf');
    theoretical_hist_uaci = normcdf(val_uaci, results.uaci_dist(1), sqrt(results.uaci_dist(2))) ...
        - normcdf([0, val_uaci(1:end-1)], results.uaci_dist(1), sqrt(results.uaci_dist(2)));
    hold on, plot(val_uaci, theoretical_hist_uaci, 'r--', 'LineWidth', 2), xlim([results.uaci_dist(1) + 4 * sqrt(results.uaci_dist(2)) * [-1,1]])
    legend('sample distribution', 'theoretical distribution', 'Location', 'southeast');
    axis square;

    % UACI cdf distribution
    subplot(224);
    bar(val_uaci, cumsum(hist_uaci / sum(hist_uaci)));
    title('UACI cdf');
    hold on, plot(val_uaci, cumsum(theoretical_hist_uaci), 'g--', 'LineWidth', 2), xlim([results.uaci_dist(1) + 4 * sqrt(results.uaci_dist(2)) * [-1,1]])
    legend('sample distribution', 'theoretical distribution', 'Location', 'southeast'); axis square;
end

