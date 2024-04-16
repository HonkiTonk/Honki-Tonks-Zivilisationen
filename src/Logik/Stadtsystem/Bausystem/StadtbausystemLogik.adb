with GrafikDatentypen;
with TastenbelegungDatentypen;
with TextnummernKonstanten;
with Grafiktask;
with AuswahlKonstanten;

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
        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = KeineBaumöglichkeit
        and
          MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = KeineBaumöglichkeit
      then
         return StadtKonstanten.LeerBauprojekt;
         
      else
         return AuswahlBauprojekt (AktuelleBauprojektExtern => LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      end if;
      
   end BauobjektAuswählen;
   
   
   
   function MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Natural
   is begin
      
      BaubareGebäude := KeineBaumöglichkeit;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                  IDExtern                 => GebäudeSchleifenwert);
         
         if
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) = True
         then
            BaubareGebäude := BaubareGebäude + 1;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      return BaubareGebäude;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   function MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Natural
   is begin
      
      BaubareEinheiten := KeineBaumöglichkeit;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop
         
         InteraktionAuswahl.MöglicheEinheiten (EinheitSchleifenwert) := EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                   IDExtern                 => EinheitSchleifenwert);
         
         if
           InteraktionAuswahl.MöglicheEinheiten (EinheitSchleifenwert) = True
         then
            BaubareEinheiten := BaubareEinheiten + 1;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return BaubareEinheiten;
      
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
                  Grafiktask.WelchesBaumenü := AktuelleAuswahl.BaumenüanzeigeÄndern;
                  
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
