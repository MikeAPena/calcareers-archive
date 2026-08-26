#!/usr/bin/env bash

# filer.sh — save a job listing to an organized directory


# -- Step 0: Welcome User ----------------------------------------------------
echo "Welcome to filer, a tool that makes it easier to save and organize job listings from the calcareers website."


# -- Step 1: Prompt for listing URL ------------------------------------------
read -rp "Please begin by pasting the calcareers job's URL: " listing_url

# -- Step 2: Prompt for organization directory --------------------------------
while true; do
    read -rp "Job title directory: " title_dir

    if [[ -d "$title_dir" ]]; then
        cd "$title_dir" || exit 1
        break
    else
        echo "Job title '$title_dir' does not exist."
        read -rp "Would you like to create it? [y/n]: " create_choice
        case "$create_choice" in
            y|Y)
                mkdir -p "$title_dir"
                echo "'$title_dir' created!"
                cd "$title_dir" || exit 1
                break
                ;;
            n|N)
                echo "OK, let's try again."
                continue
                ;;
            *)
                echo "Please enter y or n."
                continue
                ;;
        esac
    fi
done

# -- Step 3: Prompt for job code ----------------------------------------------
read -rp "Job code: " job_code
mkdir -p "$job_code"
cd "$job_code" || exit 1

# -- Step 4: Fetch and save the listing --------------------------------------
echo "Fetching listing..."
curl -s "$listing_url" | html2text > listing.txt
echo "listing.txt saved."

# -- Step 5: Reminder and cwd ------------------------------------------------
echo ""
echo "Don't forget to add the duty statement in this directory :0"
echo ""
echo "Current directory: $(pwd)"
