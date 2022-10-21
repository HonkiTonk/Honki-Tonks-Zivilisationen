pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body KIKartenfeldbewertungModifizierenLogik is

   -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln. äöü
   -- Ermittelt die Menge an belegtem Grund in der Umgebung und erhöht auf Basis dessen die Feldbewertung.
   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Bewertung_Enum
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.OberflächeKonstante =>
            null;
            
         when others =>
            if
              RasseExtern = RassenDatentypen.Ekropa_Enum
            then
               return KartenDatentypen.Null_Enum;
               
            else
               null;
            end if;
      end case;
      
      -- Die EAchse später mit berücksichtigen? äöü
      -- EAchseSchleife:
      -- for EAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEinsEAchse'Range loop
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
                              
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
                     
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                     
            elsif
              LeseWeltkarte.BelegterGrundLeer (KoordinatenExtern => KartenWert) = True
            then
               null;
            
            else
               return KartenDatentypen.Null_Enum;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      -- end loop EAchseSchleife;
         
      return KartenDatentypen.Eins_Enum; -- KIKonstanten.KartenfeldBewertungStadtBauenMinimum (RasseExtern);
      
   end BewertungStadtBauen;

end KIKartenfeldbewertungModifizierenLogik;
