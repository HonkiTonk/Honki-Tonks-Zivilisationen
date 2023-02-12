with GrafikRecordKonstanten;
with Views;
with ViewKonstanten;

package GrafikVariablen is

   InformationsfeldBereiche : GrafikRecordKonstanten.BereicheArray (Views.InformationsfeldAccesse'Range) := (
                                                                                                             ViewKonstanten.InformationsfeldStadtkarte => (0.00, 0.00, 0.25, 0.25)
                                                                                                            );

end GrafikVariablen;
