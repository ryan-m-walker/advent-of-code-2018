(def input-data
  (-> (slurp "input.txt")
      clojure.string/split-lines
      (->> (map #(Integer/parseInt %)))))

(defn find-first-repeat [shifts]
  (loop [freqs (cycle shifts)
         total 0
         seen #{}]
    (if (contains? seen total)
      total
      (recur (rest freqs)
             (+ total (first freqs))
             (conj seen total)))))

(println (find-first-repeat input-data))
