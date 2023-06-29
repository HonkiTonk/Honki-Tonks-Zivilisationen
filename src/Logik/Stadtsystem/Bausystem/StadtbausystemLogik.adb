with GrafikDatentypen;
with TastenbelegungDatentypen;
with AuswahlKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with TasteneingabeLogik;
with GebaeudeanforderungenLogik;
with EinheitenanforderungenLogik;
with NachGrafiktask;
with InteraktionAuswahl;
with MausauswahlLogik;
with OftVerwendetSound;

package body StadtbausystemLogik is

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtRecords.BauprojektRecord;
   begin
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      NeuesBauprojekt := BauobjektAuswählen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        (NeuesBauprojekt.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
         and
           NeuesBauprojekt.Einheit = AuswahlKonstanten.LeerEinheitenauswahl)
        or
          NeuesBauprojekt = AktuellesBauprojekt
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => NeuesBauprojekt);
         SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                       MaterialExtern           => StadtKonstanten.LeerMaterial,
                                       ÄndernSetzenExtern       => False);
      end if;
      
      NachGrafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Stadtkarte_Enum;
      
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
         return AuswahlBauprojekt;
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
      for EinheitSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
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
     return StadtRecords.BauprojektRecord
   is begin
      
      NachGrafiktask.Grafik.AktuelleDarstellung := GrafikDatentypen.Bauen_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Baumenü;
         NachGrafiktask.Auswahl.Bauauswahl := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
                 and
                   AktuelleAuswahl.Einheit = AuswahlKonstanten.LeerEinheitenauswahl
               then
                  null;
                  
               else
                  OftVerwendetSound.Klick;
                  return AktuelleAuswahl;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return StadtKonstanten.LeerBauprojekt;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;

end StadtbausystemLogik;
