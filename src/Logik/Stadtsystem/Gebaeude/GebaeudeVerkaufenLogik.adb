with InteraktionAuswahl;
with TastenbelegungDatentypen;
with GrafikDatentypen;
with TextnummernKonstanten;
with AuswahlKonstanten;

with LeseStadtGebaut;
with SchreibeGrafiktask;

with MausauswahlLogik;
with TasteneingabeLogik;
with GebaeudeAllgemeinLogik;
with StadtproduktionLogik;
with JaNeinLogik;
with SichtweitenGrafik;

package body GebaeudeVerkaufenLogik is
   
   procedure Verkaufsliste
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      case
        VerkaufbareGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when False =>
            return;
            
         when True =>
            GebäudeVerkaufen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Stadtumgebung_Enum);
      
   end Verkaufsliste;
   
   
   
   function VerkaufbareGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      VerkaufenMöglich := False;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                   WelchesGebäudeExtern     => GebäudeSchleifenwert);
         
         if
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) = True
           and
             VerkaufenMöglich = False
         then
            VerkaufenMöglich := True;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      return VerkaufenMöglich;
      
   end VerkaufbareGebäudeErmitteln;
   
   
   
   procedure GebäudeVerkaufen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.GebäudeID;
   begin
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Verkaufen_Enum);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Verkaufsmenü;
         SchreibeGrafiktask.Gebäudeauswahl (GebäudeExtern => AktuelleAuswahl);
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = AuswahlKonstanten.LeerGebäudeauswahl
               then
                  null;
                  
               else
                  case
                    JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGebäudeAbreißen)
                  is
                     when False =>
                        null;
                        
                     when True =>
                        GebaeudeAllgemeinLogik.GebäudeVerkaufen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                  WelchesGebäudeExtern     => AktuelleAuswahl);
                        StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
                  
                        if
                          VerkaufbareGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = True
                        then
                           null;
                        
                        else
                           exit AuswahlSchleife;
                        end if;
                  end case;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end GebäudeVerkaufen;
   
   
   
   procedure StadtkarteVerkaufen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      Grafikgröße := SichtweitenGrafik.Stadtumgebungsfläche;
      Mausposition := InteraktionAuswahl.LeseGesamteMausposition;
      
      Auswahl := Natural (Float'Floor (Mausposition.y / Grafikgröße.y)) * Positive (StadtKonstanten.Stadtkartengröße);
      Auswahl := Auswahl + Natural (Float'Ceiling (Mausposition.x / Grafikgröße.x));
      
      if
        Auswahl not in 1 .. Positive (StadtDatentypen.GebäudeIDVorhanden'Last)
      then
         return;
         
      elsif
        False = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   WelchesGebäudeExtern    => StadtDatentypen.GebäudeIDVorhanden (Auswahl))
      then
         return;
         
      else
         null;
      end if;
      
      case
        JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGebäudeAbreißen)
      is
         when False =>
            null;
                        
         when True =>
            GebaeudeAllgemeinLogik.GebäudeVerkaufen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      WelchesGebäudeExtern     => StadtDatentypen.GebäudeIDVorhanden (Auswahl));
            StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
   end StadtkarteVerkaufen;

end GebaeudeVerkaufenLogik;
