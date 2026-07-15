(require '[clojure.string :as str])

(defn calc [input]
  (let [shifts (map #(Integer/parseInt %) input)]
    (reduce (fn [seen total]
              (if (contains? seen total)
                (reduced total)
                (conj seen total)))
            #{}
            (reductions + 0 (cycle shifts)))))

(let [input (->> (slurp "input.txt")
                 (str/split-lines)
                 (remove str/blank?))]
  (println (calc input)))
