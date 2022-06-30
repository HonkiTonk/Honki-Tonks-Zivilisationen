pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;

with KIKonstanten;

with KIGrenzpruefungen;

package body KIKartenfeldbewertungModifizieren is

   -------------------------------------- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln.
   -- Ermittelt die Menge an belegtem Grund in der Umgebung und erhöht auf Basis dessen die Feldbewertung.
   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.GesamteFeldbewertung
   is begin
      
      BewertungKartenfeld := KIKonstanten.KartenfeldBewertungStadtBauenMinimum (RasseExtern);
      
      ---------------------------------------- Die EAchse später mit berücksichtigen?
      -- EAchseSchleife:
      -- for EAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEinsEAchse'Range loop
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
                              
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
                     
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                     
            elsif
              LeseKarten.BelegterGrundLeer (KoordinatenExtern => KartenWert) = True
            then
               null;
            
            else
               if
               abs (YAchseSchleifenwert) = 3
                 or
               abs (XAchseSchleifenwert) = 3
               then
                  BewertungKartenfeld := KIGrenzpruefungen.GesamteFeldbewertung (AktuellerWertExtern => BewertungKartenfeld,
                                                                                 ÄnderungExtern      => 5);
                  
               elsif
               abs (YAchseSchleifenwert) = 3
                 or
               abs (XAchseSchleifenwert) = 3
               then
                  BewertungKartenfeld := KIGrenzpruefungen.GesamteFeldbewertung (AktuellerWertExtern => BewertungKartenfeld,
                                                                                 ÄnderungExtern      => 15);
                  
               else
                  BewertungKartenfeld := KIGrenzpruefungen.GesamteFeldbewertung (AktuellerWertExtern => BewertungKartenfeld,
                                                                                 ÄnderungExtern      => 30);
               end if;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      -- end loop EAchseSchleife;
         
      return BewertungKartenfeld;
      
   end BewertungStadtBauen;

end KIKartenfeldbewertungModifizieren;
