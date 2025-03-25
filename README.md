# ⚙️ Coupler Mechanism Design – Final Project for Kinematic Design

This repository summarizes the team project conducted for the "Kinematic Design" course at Dankook University (2nd section, Team 3).  
Our objective was to design a 4-bar linkage coupler that satisfies given positional and dynamic constraints while avoiding obstacles.
![Adams구동동영상_기구설계학기말과제_2분반_3조](https://github.com/user-attachments/assets/63eb1378-492a-4474-a4b8-561b425e174c)

---

## 📌 Project Overview

- **Course:** Kinematic Design  
- **Professor:** Prof. Taejeong Kim  
- **Team Members:**  
  - Joonmo Han (Team Lead)  
  - Dongwan Ko  
  - Takyoung Kim  
  - Juhwan Park  
  - Gunho Lee  
  - Hoyoung Jeon  

- **Topic:** Coupler design for a 4-bar mechanism  
- **Submitted:** June 10, 2024

---

## 🎯 Project Goals

- The coupler must pass through two designated positions.
- It must avoid obstacles shown in the design field.
- The inclination of the coupler must not exceed 10 degrees during motion.
- All fixed joints must remain within allowed regions.
- The relation `dz/dθ = z'/θ'` should be constant.
- All links must be at least 2 grid units in length.

---

## 🛠 Tools Used

- **AutoCAD** for geometric modeling
- **Adams View** for dynamic simulation and motion analysis
- **MATLAB** for analytical modeling and graph plotting (e.g. angular vs displacement plots)

---

## 🧪 Methods

- **Geometric Construction:**  
  Used perpendicular bisectors and 2D sketching to set up feasible linkage geometries

- **Simulation:**  
  Simulated all three configurations using Adams to observe motion and verify obstacle avoidance

- **Mathematical Analysis:**  
  Used principles of virtual work and energy conservation to derive the constraint condition `dz/dθ = z'/θ'`

- **MATLAB Modeling:**  
  Plotted the motion profile and rate of change of center of mass to evaluate smoothness and consistency

---

## 🏁 Result

- Among the three models, the third configuration (with both driving and rotating joints placed lower) yielded:
  - The most stable motion
  - Least variation in `dz/dθ` over time
  - Obstacle-free and constraint-satisfying motion
- This model was finalized as the optimal design.
