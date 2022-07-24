package status

import (
	"log"
	"math"
	"time"

	"github.com/shirou/gopsutil/v3/cpu"
	"github.com/shirou/gopsutil/v3/mem"
)

func GetMemStat() int {
	mem_stat, err := mem.VirtualMemory()
	if err != nil {
		log.Fatal(err)
	}
	return int(math.Ceil(mem_stat.UsedPercent))
}

func GetCpuStat() int {
	cpu_stat, err := cpu.Percent(time.Second, false)
	if err != nil {
		log.Fatal(err)
	}
	return int(math.Ceil(cpu_stat[0]))
}
