pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen; use GrafikDatentypen;
with StadtRecords; use StadtRecords;
with StadtKonstanten;
with TastenbelegungDatentypen;
with OptionenVariablen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Eingabe;
with GebaeudeAllgemein;
with EinheitenModifizieren;
with InteraktionGrafiktask;
with GrafikEinstellungenSFML;
with InteraktionAuswahl;

package body InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
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
      
   end Bauen;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.BauprojektRecord
   is begin

      MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        GebäudeBaubar = False
        and
          EinheitenBaubar = False
      then
         return StadtKonstanten.LeerBauprojekt;
         
      elsif
        OptionenVariablen.NutzerEinstellungen.Anzeigeart = GrafikDatentypen.Grafik_SFML_Enum
      then
         return AuswahlBauprojektSFML;
         
      else
         return (0, 0);
         -- return AuswahlBauprojektTerminal;
      end if;
      
   end BauobjektAuswählen;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      GebäudeBaubar := False;
      InteraktionAuswahl.MöglicheGebäude := (others => False);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
                  
         if
           GebaeudeAllgemein.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => GebäudeSchleifenwert)
           = True
         then
            InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := True;
            
            case
              GebäudeBaubar
            is
               when False =>
                  GebäudeBaubar := True;
                  
               when True =>
                  null;
            end case;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      EinheitenBaubar := False;
      InteraktionAuswahl.MöglicheEinheiten := (others => False);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         if
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitSchleifenwert)
           = True
         then
            InteraktionAuswahl.MöglicheEinheiten (EinheitSchleifenwert) := True;
            
            case
              EinheitenBaubar
            is
               when False =>
                  EinheitenBaubar := True;
                  
               when True =>
                  null;
            end case;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;
   
   
   
   function AuswahlBauprojektSFML
     return StadtRecords.BauprojektRecord
   is begin
      
      InteraktionAuswahl.PositionenBauenFestgelegt := False;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Bauen_Enum;
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausAuswahl;
         
         case
           Eingabe.Tastenwert
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
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               GewähltesBauprojekt := StadtKonstanten.LeerBauprojekt;
               exit AuswahlSchleife;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektSFML;
   
   
   
   function MausAuswahl
     return StadtRecords.BauprojektRecord
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert).top)
                   .. Sf.sfInt32 (InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert).top + InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert).height)
                   and
                     MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert).left)
                       .. Sf.sfInt32 (InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert).left + InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert).width)
               then
                  return (GebäudeSchleifenwert, 0);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
         
      end loop GebäudeSchleife;
      
      
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert).top)
                   .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert).top + InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert).height)
                   and
                     MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert).left)
                       .. Sf.sfInt32 (InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert).left + InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert).width)
               then
                  return (0, EinheitenSchleifenwert);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
               
      end loop EinheitenSchleife;
      
      return (0, 0);
      
   end MausAuswahl;

end InDerStadtBauen;
