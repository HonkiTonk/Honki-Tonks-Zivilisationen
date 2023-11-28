with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;
with TextnummernKonstanten;
with Grafiktask;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with SchreibeGrafiktask;

with TasteneingabeLogik;
with GebaeudeanforderungenLogik;
with EinheitenanforderungenLogik;
with InteraktionAuswahl;
with MausauswahlLogik;
with OftVerwendetSound;
with JaNeinLogik;

package body StadtbausystemLogik is

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtRecords.BauprojektRecord;
   begin
      
      NeuesBauprojekt := BauobjektAuswählen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        (NeuesBauprojekt.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
         and
           NeuesBauprojekt.Einheit = AuswahlKonstanten.LeerEinheitenauswahl)
        or
          NeuesBauprojekt = LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => NeuesBauprojekt);
         SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                       MaterialExtern           => StadtKonstanten.LeerMaterial,
                                       ÄndernSetzenExtern       => False);
      end if;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Stadtumgebung_Enum);
      
   end Bauen;



   function BauobjektAuswählen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BauprojektRecord
   is begin

      if
        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = False
        and
          MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = False
      then
         return StadtKonstanten.LeerBauprojekt;
         
      else
         return AuswahlBauprojekt (AktuelleBauprojektExtern => LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      end if;
      
   end BauobjektAuswählen;
   
   
   
   function MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      BauenMöglich := False;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                           IDExtern                 => GebäudeSchleifenwert);
         
         if
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) = True
           and
             BauenMöglich = False
         then
            BauenMöglich := True;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      return BauenMöglich;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   function MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      BauenMöglich := False;
      InteraktionAuswahl.MöglicheEinheiten := (others => False);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop
         
         if
           True = EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                     IDExtern                 => EinheitSchleifenwert)
         then
            InteraktionAuswahl.MöglicheEinheiten (EinheitSchleifenwert) := True;
            
            case
              BauenMöglich
            is
               when False =>
                  BauenMöglich := True;
                  
               when True =>
                  null;
            end case;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return BauenMöglich;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   function AuswahlBauprojekt
     (AktuelleBauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtRecords.BauprojektRecord
   is begin
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Bauen_Enum);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Baumenü;
         SchreibeGrafiktask.Gebäudeauswahl (GebäudeExtern => AktuelleAuswahl.Gebäude);
         SchreibeGrafiktask.Einheitenauswahl (EinheitExtern => AktuelleAuswahl.Einheit);
         Grafiktask.Auswahl.Bauauswahl.BaumenüanzeigeÄndern := AktuelleAuswahl.BaumenüanzeigeÄndern;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.BaumenüanzeigeÄndern /= 0
               then
                  Grafiktask.Test := AktuelleAuswahl.BaumenüanzeigeÄndern;
                  
               elsif
                 AktuelleAuswahl.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
                 and
                   AktuelleAuswahl.Einheit = AuswahlKonstanten.LeerEinheitenauswahl
               then
                  null;
                  
               elsif
                 AktuelleBauprojektExtern.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
                 and
                   AktuelleBauprojektExtern.Einheit = AuswahlKonstanten.LeerEinheitenauswahl
               then
                  OftVerwendetSound.Klick;
                  return (AktuelleAuswahl.Gebäude, AktuelleAuswahl.Einheit);
                  
               elsif
                 ((AktuelleAuswahl.Gebäude /= AuswahlKonstanten.LeerGebäudeauswahl
                   and
                     AktuelleBauprojektExtern.Gebäude /= AktuelleAuswahl.Gebäude)
                  or
                    (AktuelleAuswahl.Einheit /= AuswahlKonstanten.LeerEinheitenauswahl
                     and
                       AktuelleBauprojektExtern.Einheit /= AktuelleAuswahl.Einheit))
                 and then
                   JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBauprojektWechseln) = False
               then
                  null;
                  
               else
                  OftVerwendetSound.Klick;
                  return (AktuelleAuswahl.Gebäude, AktuelleAuswahl.Einheit);
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return StadtKonstanten.LeerBauprojekt;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;

end StadtbausystemLogik;
