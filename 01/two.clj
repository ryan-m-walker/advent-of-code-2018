(require '[clojure.string :as str])

(defn first-repeat [shifts]
  ;; cycle through the shifts indefinitely, tracking every frequency
  ;; we've seen and returning the first one that shows up twice
  (loop [shifts (cycle shifts)
         total 0
         seen #{0}]
    (let [total (+ total (first shifts))]
      (if (contains? seen total)
        total
        (recur (rest shifts) total (conj seen total))))))

(let [shifts (->> (slurp "input.txt")
                  str/split-lines
                  (map #(Integer/parseInt %)))]
  (println (first-repeat shifts)))
