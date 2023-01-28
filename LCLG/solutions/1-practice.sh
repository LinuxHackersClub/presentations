#!/bin/bash

# Solution to practical task 1
# Additional feature - convertion of some operators
calculator() {
	local result=0 num1=0 num2=0 oper=0
	local -r PROMPT="> "
	while :
	do
		# Read user input
		read -p "${PROMPT}"

		# Check if reply is empty
		if [[ -z "${REPLY}" ]]; then
			echo "Bye!"
			break
		fi

		# Parse user input
		num1="${REPLY%% *}"
		REPLY="${REPLY#* }"
		oper="${REPLY%% *}"
		num2="${REPLY##* }"

		# Check if number of arguments is 2
		if [[ "${num2}" == "${oper}" ]]
		then
			num2="${oper}"
			oper="${num1}"
			num1="${result}"
		fi

		# Check if user input is valid
		if [[ "${oper}" != "+" && "${oper}" != "-" && "${oper}" != "*" && "${oper}" != "/" && "${oper}" != "^" && "${oper}" != "**" ]]
		then
			echo "Invalid operator"
			continue
		elif [[ "${oper}" == / && "${num2}" == 0 ]]; then
			echo "Division by zero is not allowed"
			continue
		elif [[ "${oper}" == "^" ]]
		then
			oper="**"
		fi

		# Calculate result
		result=$(( num1 ${oper} num2 ))

		# Print result
		echo "${result}"
	done
}


# Solution to practical task 2
# Additional feature - optional execution of files with +x permission
filemanager() {
	local -r PROMPT="> "
	while :
	do
		# Print current directory contents
		list=( $(ls --color=always --group-directories-first -FCa) )
		list_raw=( $(ls --group-directories-first -a) )
		echo "${list[@]}"

		# Read user input
		read -p "${PROMPT}"

		# Check if reply is empty
		if [[ -z "${REPLY}" ]]; then
			echo "Bye!"
			break
		fi

		# Parse user input
		local -i i=0
		for word in "${list[@]}"
		do
			if (( REPLY == i + 1 ))
			then
				file="${list_raw[$i]}"
				break
			fi
			(( i++ ))
		done

		# Check if input is a directory
		if [[ -d "${file}" ]]
		then
			cd "${file}"
			continue
		fi

		# Check if input is a file
		if [[ -f "${file}" ]]; then
			# Check if file is executable
			if [[ -x "${file}" ]]; then
				read -p "Do you want to execute ${REPLY}? [y/N] " -rn 1
				if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
					./"${file}"
				else
					cat "${file}"
				fi
			else
				cat "${file}"
			fi
			continue
		fi
	done
}


# Solution to practical task 3
# Additional feature - limited number of attempts
guessing_game() {
	local -ir NUMBER=$(( RANDOM % 100 + 1 ))
	local -r PROMPT="Attempt %i: "
	local -i attempts=5 guess_int
	for (( i = 1; i <= attempts; i++ ))
	do
		# Read user input
		printf "${PROMPT}" "${i}"
		read guess

		# Check if reply is empty
		if [[ "${guess}" == "" ]]
		then
			echo "Bye!"
			break
		fi

		# Check if input is valid
		guess_int="${guess}"
		if [[ "${guess_int}" != "${guess}" ]]
		then
			echo "Invalid input"
			(( i-- ))
			continue
		fi

		# Check if input is in range
		if (( guess_int < 1 || guess_int > 100 ))
		then
			echo "Number is out of range"
			(( i-- ))
			continue
		fi

		# Check if guess
		if (( guess == NUMBER )); then
			echo "You guessed!"
			break
		elif (( guess > NUMBER )); then
			echo "Too high"
		else
			echo "Too low"
		fi
	done
}


PS3="Select a task: "
select task in "Calculator" "File manager" "Guessing game" "Exit"
do
	case "${REPLY}" in
		1) calculator ;;
		2) filemanager ;;
		3) guessing_game ;;
		4)
			echo "Bye!"
			break
			;;
		*) echo "Invalid option" ;;
	esac
done
