package main

import (
	"strconv"

	"github.com/getlantern/systray"
	"github.com/happylie/cm-bar/pkg/status"
)

func main() {
	systray.Run(onReady, onExit)
}

func onReady() {
	go func() {
		var result string
		for {
			result = getData()
			systray.SetTitle(result)
			// time.Sleep(time.Second * 10)
		}
	}()
	systray.AddSeparator()
	mQuit := systray.AddMenuItem("Quit", "")
	go func() {
		for range mQuit.ClickedCh {
			systray.Quit()
			return
		}
	}()
}

func onExit() {

}

func getData() string {
	cpu_data := "CPU: " + strconv.Itoa(status.GetCpuStat()) + "%"
	mem_data := "MEM: " + strconv.Itoa(status.GetMemStat()) + "% "
	return cpu_data + " | " + mem_data
}
