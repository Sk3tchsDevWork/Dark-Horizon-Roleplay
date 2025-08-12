Config.Locales = Config.Locales or {}

Config.Locales['en'] = {
    -- General UI
    ['ui_close'] = 'Close',
    ['ui_cancel'] = 'Cancel',
    ['ui_confirm'] = 'Confirm',
    ['ui_save'] = 'Save',
    ['ui_loading'] = 'Loading...',
    ['ui_success'] = 'Success!',
    ['ui_failed'] = 'Failed!',
    ['ui_error'] = 'Error',
    ['ui_warning'] = 'Warning',
    ['ui_info'] = 'Information',
    
    -- Prison Management
    ['prison_management'] = 'Prison Management',
    ['prison_management_subtitle'] = 'Detention & Corrections System',
    ['new_prisoner'] = 'New Prisoner',
    ['prisoner_list'] = 'Prisoner List',
    ['server_id'] = 'Server ID',
    ['server_id_desc'] = 'Enter the Server ID of the player',
    ['sentence_duration'] = 'Sentence Duration',
    ['sentence_duration_desc'] = 'Specify the sentence duration in minutes (treated as months in-game)',
    ['required_collections'] = 'Required Collections',
    ['required_collections_desc'] = 'Number of trash items the player needs to collect',
    ['charges'] = 'Charges',
    ['charges_desc'] = 'List the charges the player is being sentenced for',
    ['fine_amount'] = 'Fine Amount',
    ['fine_amount_desc'] = 'Optional fine amount in dollars',
    ['life_sentence'] = 'Life Sentence',
    ['life_sentence_desc'] = 'Check this box if the player is receiving a life sentence',
    ['include_previous_sentence'] = 'Include Previous Sentence',
    ['include_previous_sentence_desc'] = 'Add previous sentence time for recaptured escapee',
    ['service_type'] = 'Service Type',
    ['send_to_prison'] = 'Send to Prison',
    ['assign_community_service'] = 'Assign Community Service',
    ['processing'] = 'Processing...',
    ['processed_successfully'] = 'Processed Successfully!',
    
    -- Prisoner Status
    ['player_offline'] = 'This player is currently offline.',
    ['player_in_prison'] = 'This player is currently in prison',
    ['player_in_community_service'] = 'This player is currently doing community service',
    ['player_is_escapee'] = 'This player is an escapee',
    ['checking_status'] = 'Checking status...',
    ['escaped'] = 'Escaped',
    ['community_service'] = 'Community Service',
    ['prison'] = 'Prison',
    ['collections_remaining'] = 'collections remaining',
    ['months_remaining'] = 'months remaining',
    
    -- Prisoner Actions
    ['release'] = 'Release',
    ['modify_time'] = 'Modify Time',
    ['visitable'] = 'Visitable',
    ['not_visitable'] = 'Not Visitable',
    ['modify_time_title'] = 'Modify Time',
    ['new_collections'] = 'New Collections',
    ['new_collections_desc'] = 'Enter the new number of collections required',
    ['new_time'] = 'New Time',
    ['new_time_desc'] = 'Enter the new time duration in months',
    ['time_remaining'] = 'Time Remaining:',
    ['collections_remaining_label'] = 'Collections Remaining:',
    ['save_changes'] = 'Save Changes',
    ['saving'] = 'Saving...',
    ['saved'] = 'Saved!',
    
    -- Search
    ['search_placeholder'] = 'Search by name or ID...',
    ['no_prisoners_found'] = 'No prisoners found matching your search.',
    
    -- Prison Jobs
    ['prison_jobs'] = 'Prison Jobs',
    ['prison_jobs_subtitle'] = 'Work to reduce your sentence time.',
    ['currently_working'] = 'Currently working',
    ['start_working'] = 'Start Working',
    ['end_current_job'] = 'End Current Job',
    ['confirm_job_selection'] = 'Confirm Job Selection',
    ['job_benefits_title'] = 'Working this job will:',
    ['reduce_sentence_time'] = 'Reduce your sentence time',
    ['earn_money'] = 'Earn money while serving time',
    ['end_job_warning'] = 'Are you sure you want to end your current job? You will:',
    ['stop_earning_money'] = 'Stop earning money',
    ['stop_reducing_sentence'] = 'Stop reducing your sentence',
    ['keep_working'] = 'Keep Working',
    ['end_job'] = 'End Job',
    ['no_jobs_available'] = 'No jobs available at this moment.',
    ['approx_pay'] = 'Approx.',
    
    -- Prison Shop
    ['prison_commissary'] = 'Prison Commissary',
    ['prison_commissary_subtitle'] = 'Purchase items using cash earned from prison jobs',
    ['shopping_cart'] = 'Shopping Cart',
    ['add_to_cart'] = 'Add to Cart',
    ['checkout'] = 'Checkout',
    ['stock'] = 'Stock',
    ['left'] = 'left',
    ['out_of_stock'] = 'Out of Stock',
    ['all'] = 'All',
    ['food'] = 'Food',
    ['drinks'] = 'Drinks',
    ['snacks'] = 'Snacks',
    ['not_enough_money'] = 'Not enough money',
    ['purchase_successful'] = 'Purchase successful!',
    ['some_items_out_of_stock'] = 'Some items are out of stock!',
    
    -- Illegal Shop
    ['black_market'] = 'Black Market',
    ['black_market_subtitle'] = 'Discreet transactions, no questions asked',
    ['buy_items'] = 'Buy Items',
    ['trade_items'] = 'Trade Items',
    ['make_trade'] = 'Make Trade',
    ['trade_number'] = 'Trade #',
    ['required'] = 'Required:',
    ['reward'] = 'Reward:',
    ['illegal'] = 'illegal',
    
    -- Visitation
    ['prison_visitation'] = 'Prison Visitation',
    ['prison_visitation_subtitle'] = 'Request to visit inmates currently serving time',
    ['request_visit'] = 'Request Visit',
    ['request_sent'] = 'Request Sent!',
    ['no_prisoners_visitable'] = 'No prisoners available for visitation.',
    ['minutes_remaining'] = 'minutes remaining',
    
    -- Visit Request
    ['visit_request'] = 'Visit Request',
    ['wants_to_visit'] = 'wants to visit you',
    ['accept'] = 'Accept',
    ['decline'] = 'Decline',
    
    -- Minigames
    ['circuit_board_repair'] = 'Circuit Board Repair',
    ['circuit_board_repair_subtitle'] = 'Connect the matching colored wires to repair the circuit',
    ['time_left'] = 'Time Left:',
    ['clean_the_area'] = 'Clean The Area',
    ['clean_the_area_subtitle'] = 'Click and drag over the dirty spot to clean it',
    ['progress'] = 'Progress',
    ['fix_the_wall'] = 'Fix The Wall',
    ['fix_the_wall_subtitle'] = 'Click repeatedly to repair the damaged wall',
    ['times_up'] = "Time's Up!",
    
    -- Form Validation
    ['field_required'] = 'This field is required',
    ['server_id_required'] = 'Server ID is required',
    ['charges_required'] = 'Charges are required',
    ['service_type_required'] = 'Service type is required',
    ['value_must_be_positive'] = 'Value must be at least 1',
    ['fine_must_be_positive'] = 'Fine amount must be positive',
}

-- Set default locale
Config.CurrentLocale = 'en'