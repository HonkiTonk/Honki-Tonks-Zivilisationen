with InteraktionAuswahl;
with TastenbelegungDatentypen;
with GrafikDatentypen;
with TextnummernKonstanten;

with LeseStadtGebaut;

with NachGrafiktask;
with MausauswahlLogik;
with TasteneingabeLogik;
with GebaeudeAllgemeinLogik;
with StadtproduktionLogik;
with JaNeinLogik;

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
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
   end Verkaufsliste;
   
   
   
   function VerkaufbareGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      VerkaufenMöglich := False;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
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
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Verkaufen_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Verkaufsmenü;
         NachGrafiktask.AktuelleBauauswahl.Gebäude := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = 0
               then
                  null;
                  
               else
                  case
                    JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageGebäudeAbreißen)
                  is
                     when False =>
                        null;
                        
                     when True =>
                        GebaeudeAllgemeinLogik.GebäudeEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
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

end GebaeudeVerkaufenLogik;
