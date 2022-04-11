##AWS Profile Selector
## Add below function in your .bashrc or .bash_profile and then call function aws_p,  you will see a interactive menu to set the desired AWS PROFILE
function aws_p() {
    # AWS Profile Selector
    IFS=$'\n' read -d '' -ra lines < <(grep "\[profile" ~/.aws/config  | cut -d" " -f 2 | tr -d "]")
    echo -e "\033[1;34m - - - - - - - - - - - - - - - \033[0m"
    select choice in "${lines[@]}"; do
    [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
    break # valid choice was made; exit prompt.
    done
    read -r id  <<<"$choice"
    echo -e "\033[1;32m $id \033[0m"
    export AWS_PROFILE="$id"
    aws sts get-caller-identity
    echo -e "\033[1;34m - - - - - - - - - - - - - - - \033[0m"
}

export -f aws_p

## How to Use
## Add above function and export to your .bash_profile
## Restart your terminal session
## run aws_p
