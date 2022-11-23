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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type StadtRecords.BauprojektRecord;
   begin
      
      AktuellesBauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      NeuesBauprojekt := BauobjektAuswählen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        (NeuesBauprojekt.Gebäude = 0
         and
           NeuesBauprojekt.Einheit = 0)
        or
          NeuesBauprojekt = AktuellesBauprojekt
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => NeuesBauprojekt);
         SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                         ÄndernSetzenExtern     => False);
      end if;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
   end Bauen;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.BauprojektRecord
   is begin

      GebäudeBaubar := MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      EinheitenBaubar := MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      BauenMöglich := False;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := GebaeudeAllgemeinLogik.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      BauenMöglich := False;
      InteraktionAuswahl.MöglicheEinheiten := (others => False);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         if
           True = EinheitenmodifizierungLogik.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
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
