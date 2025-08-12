Loc = Loc or {} 

Loc['de'] = {
    -- Targets
    ["target_label_cleanjob"] = "Unordnung säubern",
    ["target_label_electricaljob"] = "Stromkasten reparieren",
    ["target_label_moveboxes"] = "Kiste aufheben",
    ["target_label_dropoff_moveboxes"] = "Kiste ablegen",
    ["target_label_repairwalls"] = "Wand reparieren",

    ["target_label_prisonjobs_ped"] = "Gefängnisaufträge ansehen",

    ["target_label_comserv"] = "Müll aufsammeln",

    ["target_label_jailbreak_plant"] = "Sprengsatz legen",
    ["target_label_jailbreak_tunnel"] = "Tunnel betreten",
    ["target_label_jailbreak_swipe"] = "Schlüsselkarte scannen",
    ["target_label_jailbreak_escapedoor"] = "Schlüsselkarte scannen",

    ["target_label_foodtray_ped"] = "Essenstablett holen",
    ["target_label_toilet_stash"] = "Schmuggel verstecken",
    ["target_label_bribe"] = "Bestechung anbieten",
    ["target_label_blackmarket"] = "Mit Insassenhändler sprechen",
    ["target_label_commissary"] = "Gefängnisshop öffnen",

    ["target_label_visitation_desk"] = "Besuchs-Schalter öffnen",
    ["target_label_retrieve_items"] = "Konfiszierte Gegenstände holen",

    -- Text UIs
    ["textui_visitation"] = "Besuchszeit: %d Sekunden",
    ["textui_lifer"] = "Lebenslänglich",
    ["sentence_lifer"] = "Lebenslänglich",
    ["sentence_minutes"] = "%d Minute%s verbleibend",
    ["sentence_hours"] = "%d Stunde%s verbleibend",
    ["sentence_hours_minutes"] = "%d Stunde%s und %d Minute%s verbleibend",
    ["sentence_days"] = "%d Tag%s",
    ["sentence_days_hours"] = ", %d Stunde%s",
    ["sentence_days_minutes"] = " und %d Minute%s",
    ["sentence_remaining"] = "%s%s%s verbleibend",

    -- Notifications
    ["notifi_cleanjob_start"] = { label = "Reinigungsauftrag", text = "Beginn mit der Reinigung der Zellen. Keine Ecke auslassen." },
    ["notifi_cleanjob_failed"] = { label = "Reinigung fehlgeschlagen", text = "Die Zelle wurde nicht richtig gereinigt. Versuch es noch einmal." },
    ["notifi_job_canceled_cleaning"] = { label = "Auftrag abgebrochen", text = "Du hast den Zellreinigungsauftrag abgebrochen." },

    ["notifi_electricaljob_start"] = { label = "Reparaturauftrag", text = "Beginne mit der Reparatur der Stromkästen im Gebäude." },
    ["notifi_electricaljob_failed"] = { label = "Reparatur fehlgeschlagen", text = "Du hast den Kasten nicht richtig repariert. Versuch es nochmal." },
    ["notifi_job_canceled_electrical"] = { label = "Auftrag abgebrochen", text = "Du hast den Elektrikerauftrag abgebrochen." },

    ["notifi_moveboxes_start"] = { label = "Kisten transportieren", text = "Heb eine Kiste von der blinkenden roten Markierung auf, um zu beginnen." },
    ["notifi_moveboxes_secured"] = { label = "Kiste gesichert", text = "Bringe die Kiste jetzt zum blinkenden grünen Ablagepunkt." },
    ["notifi_job_canceled_moveboxes"] = { label = "Auftrag abgebrochen", text = "Du hast den Kistentransport-Auftrag verlassen." },

    ["notifi_repair_wall_start"] = { label = "Reparaturauftrag", text = "Beginne mit der Reparatur der beschädigten Wände im Gebäude." },
    ["notifi_repair_wall_failed"] = { label = "Reparatur fehlgeschlagen", text = "Die Reparatur war nicht erfolgreich. Versuch es nochmal." },
    ["notifi_job_canceled_repair"] = { label = "Auftrag abgebrochen", text = "Du hast den Wandreparatur-Auftrag verlassen." },

    ["notifi_job_complete_cleaning"] = { label = "Auftrag abgeschlossen", text = "Alle Zellen sind gereinigt. Gut gemacht." },
    ["notifi_job_complete_electrical"] = { label = "Auftrag abgeschlossen", text = "Alle Stromkästen funktionieren wieder. Gut gemacht." },
    ["notifi_job_complete_boxes"] = { label = "Auftrag abgeschlossen", text = "Alle Kisten wurden umgestellt. Gut gemacht." },
    ["notifi_job_complete_repairs"] = { label = "Auftrag abgeschlossen", text = "Alle Wände wurden repariert. Gut gemacht." },

    ["notifi_job_complete_sentence_reduction"] = { label = "Auftrag abgeschlossen", text = "%d Minuten von deiner Strafe abgezogen und $%d Gefängnisgeld erhalten." },
    ["notifi_job_complete_no_reward"] = { label = "Auftrag abgeschlossen", text = "Keine Strafenreduzierung oder Vergütung, aber du hast vielleicht etwas Nützliches gefunden..." },

    ["notifi_comserv_start"] = { label = "Gemeinnützige Arbeit", text = "Du wurdest zur Reinigung von Bereichen eingeteilt. Leg los." },
    ["notifi_comserv_leavezone"] = { label = "Bleib in der Zone", text = "Lauf nicht weg. Leg weiter los." },
    ["notifi_comserv_occupied"] = { label = "Bereich besetzt", text = "Jemand anderes arbeitet hier bereits. Finde einen anderen." },
    ["notifi_comserv_collected"] = { label = "Müll gesammelt", text = "Gut gemacht. Verbleibende Aufräumaktionen: " },
    ["notifi_comserv_complete"] = { label = "Arbeit beendet", text = "Du hast deine Zeit abgesessen. Bleib auf dem rechten Weg." },

    ["notifi_jailbreak_cooldown"] = { label = "Abklingzeit", text = "Vor kurzem wurde ein Ausbruchversuch unternommen. Versuch es später erneut." },
    ["notifi_jailbreak_failed"] = { label = "Ausbruch fehlgeschlagen", text = "Dein Ausbruchsversuch ist fehlgeschlagen, du wurdest zurück in die Zelle gebracht." },
    ["notifi_jailbreak_error"] = { label = "Fehler", text = "Tür ist verschlossen oder Abklingzeit aktiv!" },
    ["notifi_jailbreak_escaped"] = { label = "Ausbruch gelungen", text = "Du bist erfolgreich ausgebrochen. Die Jagd beginnt..." },

    ["notifi_job_actionblocked"] = { label = "Aktion blockiert", text = "Beende oder breche deinen aktuellen Auftrag ab, bevor du einen neuen beginnst." },
    ["notifi_job_nojob"] = { label = "Kein Auftrag aktiv", text = "Du hast momentan keinen zugewiesenen Auftrag." },

    ["notifi_foodtray_mealtaken"] = { label = "Essen bereits genommen", text = "Du hast deine Mahlzeit bereits abgeholt." },
    ["notifi_foodtray_mealreceived"] = { label = "Mahlzeit erhalten", text = "Du hast dein Tablett erhalten." },
    ["notifi_foodtray_missingitem"] = { label = "Kein Tablett", text = "Du hast kein Gefängnistray." },
    ["notifi_meal_morning"] = { label = "Essenszeit", text = "Das Frühstück wird jetzt in der Cafeteria serviert." },
    ["notifi_meal_evening"] = { label = "Essenszeit", text = "Das Abendessen ist bereit, geh zur Cafeteria und iss." },

    ["notifi_jailed"] = { label = "Inhaftiert", text = "Du wurdest eingeliefert und eingesperrt." },
    ["notifi_already_jailed"] = { label = "Bereits in Haft", text = "Dieser Spieler befindet sich bereits im Gefängnis." },
    ["notifi_released"] = { label = "Freigelassen", text = "Du hast deine Strafe abgesessen. Du bist frei." },

    ["notifi_visitation_start"] = { label = "Besuch gestartet", text = "Dein Besuch hat begonnen. Nutze die Zeit." },
    ["notifi_visitation_end"] = { label = "Besuch beendet", text = "Der Besuch ist vorbei. Du wurdest zurück in die Zelle gebracht." },
    ["notifi_visit_request_denied"] = { label = "Anfrage abgelehnt", text = "Dieser Insasse hat kürzlich bereits eine Besuchsanfrage erhalten. Versuch es später erneut." },
    ["notifi_visit_request_sent"] = { label = "Anfrage gesendet", text = "Die Besuchsanfrage wurde an den Insassen gesendet." },
    ["notifi_visit_offline_prisoner"] = { label = "Insasse offline", text = "Dieser Insasse ist derzeit nicht online." },

    ["notifi_bribe_failed_empty"] = { label = "Bestechung fehlgeschlagen", text = "Du hast nichts, was du anbieten könntest." },
    ["notifi_bribe_accepted"] = { label = "Bestechung akzeptiert", text = "\"In Ordnung... Nimm es und bereue es mir nicht.\"" },
    ["notifi_bribe_failed_penalty"] = { label = "Bestechung fehlgeschlagen", text = "\"Dachtest du wirklich, das würde klappen? Idiot. Ich habe deine Strafe verlängert.\"" },

    ["notifi_access_denied_retrieve"] = { label = "Zugriff verweigert", text = "Du kannst keine Gegenstände holen, solange du inhaftiert bist." },
    ["notifi_items_returned"] = { label = "Gegenstände zurückgegeben", text = "Deine konfiszierten Gegenstände wurden zurückgegeben." },
    ["notifi_no_items"] = { label = "Keine Gegenstände", text = "Du hast keine konfiszierten Gegenstände." },

    ["notifi_fine_issued"] = { label = "Geldstrafe verhängt", text = "Dir wurden $%s von deinem Bankkonto abgezogen." },

    ["notifi_actionfailed"] = { label = "Aktion fehlgeschlagen", text = "Du musst in der Nähe des Insassen sein, um diese Aktion auszuführen." },
    ["notifi_access_denied"] = { label = "Zugriff verweigert", text = "Du bist nicht autorisiert." },

    ["notifi_actionfailed_release"] = { label = "Aktion fehlgeschlagen", text = "Du musst in der Nähe des Insassen sein, um ihn zu befreien." },
    ["notifi_access_denied_release"] = { label = "Zugriff verweigert", text = "Du bist nicht autorisiert, Insassen zu befreien." },
    ["notifi_success_release"] = { label = "Erfolg", text = "Insasse erfolgreich freigelassen." },

    ["notifi_actionfailed_modify"] = { label = "Aktion fehlgeschlagen", text = "Du musst in der Nähe des Insassen sein, um seine Strafe zu ändern." },
    ["notifi_access_denied_modify"] = { label = "Zugriff verweigert", text = "Du bist nicht autorisiert, Strafen zu ändern." },
    ["notifi_success_modify"] = { label = "Erfolg", text = "Strafe erfolgreich geändert." },

    ["notifi_actionfailed_jail"] = { label = "Aktion fehlgeschlagen", text = "Du musst in der Nähe des Verdächtigen sein, um ihn einzusperren." },
    ["notifi_access_denied_jail"] = { label = "Zugriff verweigert", text = "Du bist nicht autorisiert, Spieler zu inhaftieren." },
    ["notifi_success_jail"] = { label = "Erfolg", text = "Spieler erfolgreich ins Gefängnis geschickt." },
}
