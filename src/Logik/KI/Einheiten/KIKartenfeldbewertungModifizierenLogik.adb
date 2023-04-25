with KartenKonstanten;
with BewertungDatentypen;
with GrafikKonstanten;

with LeseWeltkarte;
with LeseKartenDatenbanken;

with KartenkoordinatenberechnungssystemLogik;

package body KIKartenfeldbewertungModifizierenLogik is

   -- Später Spezies/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln? äöü
   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.OberflächeKonstante =>
            null;
            
         when others =>
            if
              SpeziesExtern = SpeziesDatentypen.Ekropa_Enum
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
                             SpeziesExtern     => SpeziesExtern);
            
         when False =>
            return False;
      end case;
      
   end BewertungStadtBauen;
   
   
   
   -- Das später Speziesspezifische anpassen? äöü
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is begin
      
      GuteFelder := GrafikKonstanten.Nullwert;
      
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
                 LeseKartenDatenbanken.BewertungBasisgrund (GrundExtern   => LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern),
                                                            SpeziesExtern => SpeziesExtern)
               in BewertungDatentypen.Fehlschlag
                 and
                   LeseKartenDatenbanken.BewertungZusatzgrund (GrundExtern   => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                               SpeziesExtern => SpeziesExtern)
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
                  GuteFelder := GuteFelder + 1.00 / GrafikKonstanten.Halbierung;
                  
               else
                  GuteFelder := GuteFelder + 1.00;
               end if;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
            
      if
        GuteFelder > KartenfeldBewertungStadtBauenMinimum (SpeziesExtern)
      then
         return True;
         
      else
         return False;
      end if;
      
   end GutGenug;

end KIKartenfeldbewertungModifizierenLogik;
