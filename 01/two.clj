(ns two
  (:require [clojure.string :as str]))

(defn calc
  "Find the first frequency reached twice, cycling through the shifts as
  needed. Keeps a running total and a set of every total seen so far."
  [shifts]
  (reduce (fn [seen total]
            (if (contains? seen total)
              (reduced total)
              (conj seen total)))
          #{}
          (reductions + 0 (cycle shifts))))

(defn -main []
  (let [shifts (->> (slurp "input.txt")
                    (str/split-lines)
                    (remove str/blank?)
                    (map #(Integer/parseInt %)))]
    (println (calc shifts))))

(-main)
