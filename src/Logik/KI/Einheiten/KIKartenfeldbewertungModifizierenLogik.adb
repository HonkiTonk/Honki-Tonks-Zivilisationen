with KartenKonstanten;
with BewertungDatentypen;

with LeseWeltkarte;
with LeseKartenDatenbanken;

with KartenkoordinatenberechnungssystemLogik;

package body KIKartenfeldbewertungModifizierenLogik is

   -- Später Rassen/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln? äöü
   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.OberflächeKonstante =>
            null;
            
         when others =>
            if
              RasseExtern = RassenDatentypen.Ekropa_Enum
            then
               return False;
               
            else
               null;
            end if;
      end case;
      
      case
        StadtabstandVorhanden (KoordinatenExtern => KoordinatenExtern)
      is
         when True =>
            return GutGenug (KoordinatenExtern => KoordinatenExtern,
                             RasseExtern       => RasseExtern);
            
         when False =>
            return False;
      end case;
      
   end BewertungStadtBauen;
   
   
   
   -- Das später rassenspezifische anpassen? äöü
   function StadtabstandVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
            
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
              LeseWeltkarte.UnbelegterGrund (KoordinatenExtern => KartenWert) = False
            then
               return False;
            
            else
               null;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return True;
      
   end StadtabstandVorhanden;
   
   
   
   function GutGenug
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      GuteFelder := 0.00;
      
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
                     
            else
               if
                 LeseKartenDatenbanken.BewertungBasisgrund (GrundExtern => LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern),
                                                            RasseExtern => RasseExtern)
               in BewertungDatentypen.Fehlschlag
                 and
                   LeseKartenDatenbanken.BewertungZusatzgrund (GrundExtern => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                               RasseExtern => RasseExtern)
               in BewertungDatentypen.Fehlschlag
               then
                  null;
                  
               elsif
               abs (YAchseSchleifenwert) = 3
                 or
               abs (YAchseSchleifenwert) = 3
               then
                  GuteFelder := GuteFelder + 1.00 / 3.00;
                  
               elsif
               abs (YAchseSchleifenwert) = 2
                 or
               abs (YAchseSchleifenwert) = 2
               then
                  GuteFelder := GuteFelder + 1.00 / 2.00;
                  
               else
                  GuteFelder := GuteFelder + 1.00;
               end if;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
            
      if
        GuteFelder > KartenfeldBewertungStadtBauenMinimum (RasseExtern)
      then
         return True;
         
      else
         return False;
      end if;
      
   end GutGenug;

end KIKartenfeldbewertungModifizierenLogik;
