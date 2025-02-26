#!/bin/bash

# GitHub API Token (optional, recommended to avoid rate limits)
#GITHUB_TOKEN="your_github_token_here"  # Leave empty "" if not using

fetch_repos() {
    local keywords="$1"
    local year="$2"
    local language="$3"
    local license="$4"
    local page=1
    local per_page=100
    local total_downloaded=0 

    case "$license" in
        "mit") license="MIT" ;;
        "apache-2.0") license="Apache-2.0" ;;
        "gpl-3.0") license="GPL-3.0" ;;
    esac

    local formatted_keywords=$(echo "$keywords" | sed 's/ /+/g')


    local query="${formatted_keywords}+created:>=$year-01-01"
    [[ -n "$language" ]] && query+="+language:$language"
    [[ -n "$license" ]] && query+="+license:$license"


    echo "Query URL: https://api.github.com/search/repositories?q=$query&sort=stars&order=desc&per_page=$per_page&page=$page"

    while :; do
        echo "Fetching page $page of repositories..."
        response=$(curl -s -H "Accept: application/vnd.github.v3+json" \
                        "https://api.github.com/search/repositories?q=$query&sort=stars&order=desc&per_page=$per_page&page=$page")


        if echo "$response" | grep -q "message"; then
            echo "Error: $(echo "$response" | jq -r '.message')"
            exit 1
        fi


        repo_urls=$(echo "$response" | jq -r '.items[].clone_url')


        if [[ -z "$repo_urls" || "$repo_urls" == "null" ]]; then
            echo "No more repositories found or invalid response."
            break
        fi


        for repo in $repo_urls; do
            echo "Repository found: $repo"
            echo "Cloning: $repo"
            git clone "$repo"
            ((total_downloaded++))
        done

        ((page++))
        sleep 2
    done

    echo "Download complete: $total_downloaded repositories downloaded."
}


read -p "Enter keywords (space-separated, press Enter to fetch ALL repos): " keywords
read -p "Enter release year (YYYY): " year
read -p "Enter programming language (optional, press Enter to skip): " language
read -p "Enter license type (optional, e.g., MIT, Apache-2.0, GPL-3.0, press Enter to skip): " license


if [[ -z "$year" ]]; then
    echo "Error: Release year is required."
    exit 1
fi


if [[ -z "$keywords" ]]; then
    echo "No keywords provided. Fetching ALL repositories from $year onwards..."
    keywords="stars:>1000"
fi


output_dir="github_repos_${year}"
mkdir -p "$output_dir" || { echo "Failed to create directory $output_dir"; exit 1; }
cd "$output_dir" || { echo "Failed to change to directory $output_dir"; exit 1; }


fetch_repos "$keywords" "$year" "$language" "$license"
