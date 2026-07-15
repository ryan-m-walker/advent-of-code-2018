(require '[clojure.string :as str])

(defn calc [input]
  ;; cycle the shifts forever, keeping a running total and the set of
  ;; totals we've already seen. the first total we hit twice is the answer.
  (loop [shifts (cycle input)
         total 0
         seen #{0}]
    (let [next-total (+ total (first shifts))]
      (if (contains? seen next-total)
        next-total
        (recur (rest shifts) next-total (conj seen next-total))))))

(defn -main []
  (let [input (->> (slurp "input.txt")
                   (str/split-lines)
                   (remove str/blank?)
                   (map #(Integer/parseInt %)))]
    (println (calc input))))

(-main)
