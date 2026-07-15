(require '[clojure.string :as str])

(defn calc [input]
  (let [shifts (map #(Integer/parseInt %) (str/split-lines input))]
    (loop [total 0
           seen #{0}
           [shift & rest] (cycle shifts)]
      (let [next-total (+ total shift)]
        (if (contains? seen next-total)
          next-total
          (recur next-total (conj seen next-total) rest))))))

(println (calc (slurp "input.txt")))
