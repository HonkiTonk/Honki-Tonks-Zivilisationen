with KampfRecords;

package KampfRecordKonstanten is
   pragma Pure;
   
   LeerKampfwerte : constant KampfRecords.KampfwerteRecord := (
                                                               Angriff      => 1,
                                                               Verteidigung => 1
                                                              );

   -- Wird verwendet, wenn sowohl der Angreifer als auch der Verteidiger nur über leere Kampfwerte verfügt.
   Sicherheitskampfwerte : constant KampfRecords.KampfwerteRecord := (
                                                                      Angriff      => 1,
                                                                      Verteidigung => 1
                                                                     );

end KampfRecordKonstanten;
