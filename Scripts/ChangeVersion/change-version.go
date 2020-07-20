package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os/exec"
	"strings"
)

func main() {
	gitBranchBytes, err := exec.Command("/bin/sh", "Scripts/ChangeVersion/git-version.sh").Output()
	if err != nil {
		log.Fatalln(err)
	}
	currentBranch := string(gitBranchBytes)
	splittedBranchName := strings.Split(currentBranch, "/")
	isReleaseBranch := splittedBranchName[0] == "release"
	if isReleaseBranch {
		versionNumber := splittedBranchName[1]
		xCodeProjFilePath := "PassLibrary.xcodeproj/project.pbxproj"
		xCodeProjBytes, err := ioutil.ReadFile(xCodeProjFilePath)
		if err != nil {
			log.Fatalln(err)
		}
		lines := strings.Split(string(xCodeProjBytes), "\n")
		hasChanges := false
		for lineNumber, line := range lines {
			if strings.Contains(line, "MARKETING_VERSION = ") {
				oneTab := "	"
				amountOfTabs := strings.Count(line, oneTab)
				tabsToAdd := ""
				for i := 0; i < amountOfTabs; i++ {
					tabsToAdd += oneTab
				}
				newString := tabsToAdd + "MARKETING_VERSION = " + versionNumber + ";\n"
				if lines[lineNumber] != newString {
					lines[lineNumber] = newString
					hasChanges = true
					fmt.Println("Changed", lines[lineNumber], "in to:")
					fmt.Println(newString)
				}

			}
		}
		if hasChanges {
			output := strings.Join(lines, "\n")
			err = ioutil.WriteFile(xCodeProjFilePath, []byte(output), 0644)
			if err != nil {
				log.Fatalln(err)
			}
			return
		}
	}
	fmt.Println("No changes made to XCodeProj file")
}
