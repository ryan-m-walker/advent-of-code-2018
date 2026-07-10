(require '[clojure.string :as str])

(defn calc [input-data]
  ;; Cycle through the shifts forever, keeping a running total and a set of
  ;; every frequency we've already seen. The first total that repeats is the
  ;; answer, so we return as soon as `seen` already contains it.
  (loop [total 0
         seen #{}
         shifts (cycle input-data)]
    (if (contains? seen total)
      total
      (recur (+ total (first shifts))
             (conj seen total)
             (rest shifts)))))

(let [input-data (->> (slurp "input.txt")
                      (str/split-lines)
                      (remove str/blank?)
                      (map #(Integer/parseInt %)))]
  (println (calc input-data)))
