(require '[clojure.string :as str])

(defn calc [input]
  ;; cycle the shifts endlessly, keeping a running total and the set of
  ;; frequencies we have already seen (starting at 0). The first total we
  ;; reach a second time is the answer.
  (let [shifts (map #(Integer/parseInt %) input)]
    (loop [[shift & more] (cycle shifts)
           total 0
           seen #{0}]
      (let [next-total (+ total shift)]
        (if (contains? seen next-total)
          next-total
          (recur more next-total (conj seen next-total)))))))

(let [input (str/split-lines (slurp "input.txt"))]
  (println (calc input)))
