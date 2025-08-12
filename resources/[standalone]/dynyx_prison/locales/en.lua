Loc = Loc or {} 

Loc['en'] = {
    -- Targets
    ["target_label_cleanjob"] = "Clean Mess",
    ["target_label_electricaljob"] = "Repair Electrical Panel",
    ["target_label_moveboxes"] = "Pick up box",
    ["target_label_dropoff_moveboxes"] = "Drop off box",
    ["target_label_repairwalls"] = "Repair Wall",

    ["target_label_prisonjobs_ped"] = "View Prison Jobs",

    ["target_label_comserv"] = "Pick Up Trash",

    ["target_label_jailbreak_plant"] = "Plant Explosive",
    ["target_label_jailbreak_tunnel"] = "Enter Tunnel",
    ["target_label_jailbreak_swipe"] = "Swipe Keycard",
    ["target_label_jailbreak_escapedoor"] = "Swipe Keycard",

    ["target_label_foodtray_ped"] = "Get Food Tray",
    ["target_label_toilet_stash"] = "Hide Contrabands",
    ["target_label_bribe"] = "Offer Bribe",
    ["target_label_blackmarket"] = "Talk to Inmate Dealer",
    ["target_label_commissary"] = "Open Commissary Shop",

    ["target_label_visitation_desk"] = "Open Visitation Desk",
    ["target_label_retrieve_items"] = "Retrieve Confiscated Items",

    -- Text Uis
    ["textui_visitation"] = "Visitation Time: %d seconds",
    ["textui_lifer"] = "Lifer",
    ["sentence_lifer"] = "Lifer",
    ["sentence_minutes"] = "%d minute%s remaining",
    ["sentence_hours"] = "%d hour%s remaining",
    ["sentence_hours_minutes"] = "%d hour%s and %d minute%s remaining",
    ["sentence_days"] = "%d day%s",
    ["sentence_days_hours"] = ", %d hour%s",
    ["sentence_days_minutes"] = " and %d minute%s",
    ["sentence_remaining"] = "%s%s%s remaining",


    -- Notifications
    ["notifi_cleanjob_start"] = {
        label = "Cleaning Assignment",
        text = "Start cleaning the prison cells. Don’t miss a spot."
    },
    ["notifi_cleanjob_failed"] = {
        label = "Cleaning Failed",
        text = "You didn’t clean the cell properly. Give it another shot."
    },
    ["notifi_job_canceled_cleaning"] = {
        label = "Job Canceled",
        text = "You’ve abandoned the cell cleaning task."
    },

    ["notifi_electricaljob_start"] = {
        label = "Repair Assignment",
        text = "Begin fixing the broken electrical panels around the facility."
    },
    ["notifi_electricaljob_failed"] = {
        label = "Repair Failed",
        text = "You didn’t fix the panel correctly. Try again."
    },
    ["notifi_job_canceled_electrical"] = {
        label = "Job Canceled",
        text = "You abandoned the electrician task."
    },

    ["notifi_moveboxes_start"] = {
        label = "Move Boxes",
        text = "Pick up a box from a blinking red marker to begin your shift."
    },
    ["notifi_moveboxes_secured"] = {
        label = "Box Secured",
        text = "Now deliver the box to the blinking green drop-off point."
    },
    ["notifi_job_canceled_moveboxes"] = {
        label = "Job Canceled",
        text = "You left the area. Box relocation task canceled."
    },

    ["notifi_repair_wall_start"] = {
        label = "Repair Assignment",
        text = "Begin repairing the damaged facility walls. Tools ready."
    },
    ["notifi_repair_wall_failed"] = {
        label = "Repair Failed",
        text = "The repair wasn’t successful. Try again."
    },
    ["notifi_job_canceled_repair"] = {
        label = "Job Canceled",
        text = "You’ve exited the facility repair job."
    },

    ["notifi_job_complete_cleaning"] = {
        label = "Job Complete",
        text = "All assigned cells have been cleaned. Good work."
    },
    ["notifi_job_complete_electrical"] = {
        label = "Job Complete",
        text = "All electrical panels are working again. Nice job."
    },
    ["notifi_job_complete_boxes"] = {
        label = "Job Complete",
        text = "All boxes have been relocated. Nice work."
    },
    ["notifi_job_complete_repairs"] = {
        label = "Job Complete",
        text = "All wall repairs are finished. Great work."
    },

    ["notifi_job_complete_sentence_reduction"] = {
        label = "Job Complete",
        text = "%d minutes off your sentence and $%d prison funds earned."
    },
    ["notifi_job_complete_no_reward"] = {
        label = "Job Complete",
        text = "No sentence reduction or pay earned, but you might’ve found something useful..."
    },

    ["notifi_comserv_start"] = {
        label = "Community Service Assigned",
        text = "You’ve been assigned to clean the area. Get to work."
    },
    ["notifi_comserv_leavezone"] = {
        label = "Stay in the Area",
        text = "Don’t try to run. Get back to work."
    },
    ["notifi_comserv_occupied"] = {
        label = "Occupied",
        text = "Someone else is already cleaning this spot. Find another."
    },
    ["notifi_comserv_collected"] = {
        label = "Trash Collected",
        text = "Nice work. Remaining pickups: "
    },
    ["notifi_comserv_complete"] = {
        label = "Community Service Complete",
        text = "You’ve served your time. Stay out of trouble."
    },

    ["notifi_jailbreak_cooldown"] = {
        label = "Cooldown",
        text = "A prison break was attempted recently. Try again later."
    },
    ["notifi_jailbreak_failed"] = {
        label = "Escape Failed",
        text = "You tried to escape and have been returned to your cell."
    },
    ["notifi_jailbreak_error"] = {
        label = "Error",
        text = "Door is locked or cooldown active!"
    },
    ["notifi_jailbreak_escaped"] = {
        label = "Prison Escape",
        text = "You successfully escaped prison. The hunt begins..."
    },

    ["notifi_job_actionblocked"] = {
        label = "Action Blocked",
        text = "Finish or cancel your current job before starting another."
    },
    ["notifi_job_nojob"] = {
        label = "No Active Job",
        text = "You don’t have any job assigned right now."
    },

    ["notifi_foodtray_mealtaken"] = {
        label = "Meal Already Taken",
        text = "You’ve already received your food for this mealtime."
    },
    ["notifi_foodtray_mealreceived"] = {
        label = "Meal Received",
        text = "You picked up a food tray."
    },
    ["notifi_foodtray_missingitem"] = {
        label = "Missing Item",
        text = "You don’t have a prison tray."
    },
    ["notifi_meal_morning"] = {
        label = "Meal Time",
        text = "Morning meal is now being served in the cafeteria."
    },
    ["notifi_meal_evening"] = {
        label = "Meal Time",
        text = "Evening meal is ready, head to the cafeteria to eat."
    },

    ["notifi_jailed"] = {
        label = "Incarcerated",
        text = "You’ve been processed and locked up."
    },
    ["notifi_already_jailed"] = {
        label = "Already Jailed",
        text = "This player is currently serving time."
    },
    ["notifi_released"] = {
        label = "Released",
        text = "You’ve served your sentence. You’re free to go."
    },

    ["notifi_visitation_start"] = {
        label = "Visitation Started",
        text = "You are now in visitation. Make it count."
    },
    ["notifi_visitation_end"] = {
        label = "Visitation Ended",
        text = "Visitation is over. You’ve been escorted back to your cell."
    },
    ["notifi_visit_request_denied"] = {
        label = "Request Denied",
        text = "That prisoner recently got a visit request. Try again shortly."
    },
    ["notifi_visit_request_sent"] = {
        label = "Request Sent",
        text = "Visit request has been delivered to the prisoner."
    },
    ["notifi_visit_offline_prisoner"] = {
        label = "Offline Prisoner",
        text = "That prisoner is currently not online."
    },
    
    ["notifi_bribe_failed_empty"] = {
        label = "Bribe Failed",
        text = "You don’t have anything to offer."
    },
    ["notifi_bribe_accepted"] = {
        label = "Bribe Accepted",
        text = "\"Alright... Take this and don’t make me regret it.\""
    },
    ["notifi_bribe_failed_penalty"] = {
        label = "Bribe Failed",
        text = "\"You really thought that would work? Idiot. I just added more time to your sentence.\""
    },

    ["notifi_access_denied_retrieve"] = {
        label = "Access Denied",
        text = "You cannot retrieve items while still serving time."
    },
    ["notifi_items_returned"] = {
        label = "Items Returned",
        text = "Your confiscated items have been returned."
    },
    ["notifi_no_items"] = {
        label = "No Items",
        text = "You have no confiscated items to retrieve."
    },

    ["notifi_fine_issued"] = {
        label = "Fine Issued",
        text = "You have been fined $%s from your bank account."
    },

    ["notifi_actionfailed"] = {
        label = "Action Failed",
        text = "You must be near the inmate to perform this action."
    },
    ["notifi_access_denied"] = {
        label = "Access Denied",
        text = "You are not authorized."
    },
    
    ["notifi_actionfailed_release"] = {
        label = "Action Failed",
        text = "You must be near the inmate to release them."
    },
    ["notifi_access_denied_release"] = {
        label = "Access Denied",
        text = "You are not authorized to release inmates."
    },
    ["notifi_success_release"] = {
        label = "Success",
        text = "Inmate released successfully."
    },

    ["notifi_actionfailed_modify"] = {
        label = "Action Failed",
        text = "You must be near the inmate to modify their sentence."
    },
    ["notifi_access_denied_modify"] = {
        label = "Access Denied",
        text = "You are not authorized to modify sentences."
    },
    ["notifi_success_modify"] = {
        label = "Success",
        text = "Sentence updated successfully."
    },

    ["notifi_actionfailed_jail"] = {
        label = "Action Failed",
        text = "You must be near the suspect to jail them."
    },
    ["notifi_access_denied_jail"] = {
        label = "Access Denied",
        text = "You are not authorized to jail players."
    },
    ["notifi_success_jail"] = {
        label = "Success",
        text = "Player sent to prison successfully."
    },
}