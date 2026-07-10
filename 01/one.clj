(require '[clojure.string :as str])

(defn calc [input-data]
  (->> input-data
       (map #(Integer/parseInt %))
       (reduce +)))

(let [input-data (->> (slurp "input.txt")
                      (str/split-lines)
                      (remove str/blank?))]
  (println (calc input-data)))
