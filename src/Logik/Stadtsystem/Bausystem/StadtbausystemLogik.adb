with GrafikDatentypen;
with TastenbelegungDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with TasteneingabeLogik;
with GebaeudeAllgemeinLogik;
with EinheitenmodifizierungLogik;
with NachGrafiktask;
with InteraktionAuswahl;
with MausauswahlLogik;

package body StadtbausystemLogik is

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtRecords.BauprojektRecord;
   begin
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      NeuesBauprojekt := BauobjektAuswählen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        (NeuesBauprojekt.Gebäude = 0
         and
           NeuesBauprojekt.Einheit = 0)
        or
          NeuesBauprojekt = AktuellesBauprojekt
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern       => NeuesBauprojekt);
         SchreibeStadtGebaut.Ressourcen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                         ÄndernSetzenExtern     => False);
      end if;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
   end Bauen;



   function BauobjektAuswählen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BauprojektRecord
   is begin

      GebäudeBaubar := MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      EinheitenBaubar := MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      if
        GebäudeBaubar = False
        and
          EinheitenBaubar = False
      then
         return StadtKonstanten.LeerBauprojekt;
         
      else
         return AuswahlBauprojektSFML;
      end if;
      
   end BauobjektAuswählen;
   
   
   
   function MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      BauenMöglich := False;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := GebaeudeAllgemeinLogik.GebäudeAnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                               IDExtern               => GebäudeSchleifenwert);
         
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
           True = EinheitenmodifizierungLogik.EinheitAnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                            IDExtern               => EinheitSchleifenwert)
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
   
   
   
   function AuswahlBauprojektSFML
     return StadtRecords.BauprojektRecord
   is begin
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Bauen_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Baumenü;
         NachGrafiktask.AktuelleBauauswahl := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.Gebäude = 0
                 and
                   AktuelleAuswahl.Einheit = 0
               then
                  null;
                  
               else
                  GewähltesBauprojekt := AktuelleAuswahl;
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               GewähltesBauprojekt := StadtKonstanten.LeerBauprojekt;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektSFML;

end StadtbausystemLogik;
