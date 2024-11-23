with KartenKonstanten;
with DatentypenHTB6;
with GrafikKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with LeseKartenDatenbanken;

with KartenkoordinatenberechnungssystemLogik;

package body KIKartenfeldbewertungModifizierenLogik is

   -- Später Spezies/Technolgie/Sonstigesabhängig die Mindestbewertung ermitteln? äöü
   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        KoordinatenExtern.Ebene
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
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
            
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungDrei'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungDrei'Range loop
                              
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                     
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.UnbelegterGrund (KoordinatenExtern => KartenWert) = False
            then
               return False;
            
            else
               null;
            end if;
               
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return True;
      
   end StadtabstandVorhanden;
   
   
   
   function GutGenug
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
      
      GuteFelder := GrafikKonstanten.Nullwert;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungDrei'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungDrei'Range loop
                              
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                     
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                     
            else
               if
                 LeseKartenDatenbanken.BewertungBasisgrund (GrundExtern   => LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern),
                                                            SpeziesExtern => SpeziesExtern)
               in DatentypenHTB6.Fehlschlag
                 and
                   LeseKartenDatenbanken.BewertungZusatzgrund (GrundExtern   => LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern),
                                                               SpeziesExtern => SpeziesExtern)
               in DatentypenHTB6.Fehlschlag
               then
                  null;
                  
               elsif
               abs (SenkrechteSchleifenwert) = 3
                 or
               abs (SenkrechteSchleifenwert) = 3
               then
                  GuteFelder := GuteFelder + 1.00 / 3.00;
                  
               elsif
               abs (SenkrechteSchleifenwert) = 2
                 or
               abs (SenkrechteSchleifenwert) = 2
               then
                  GuteFelder := GuteFelder + 1.00 / GrafikKonstanten.Halbierung;
                  
               else
                  GuteFelder := GuteFelder + 1.00;
               end if;
            end if;
               
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
            
      if
        GuteFelder > KartenfeldBewertungStadtBauenMinimum (SpeziesExtern)
      then
         return True;
         
      else
         return False;
      end if;
      
   end GutGenug;

end KIKartenfeldbewertungModifizierenLogik;
