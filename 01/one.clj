(require '[clojure.string :as str])

(defn calc
  "Sum every frequency shift to get the resulting frequency."
  [shifts]
  (reduce + (map #(Long/parseLong %) shifts)))

(let [shifts (->> (slurp "input.txt")
                  str/split-lines
                  (remove str/blank?))]
  (println (calc shifts)))
