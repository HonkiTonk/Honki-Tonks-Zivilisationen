pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics.RenderWindow;

with GrafikDatentypen; use GrafikDatentypen;
with StadtRecords; use StadtRecords;
with StadtKonstanten;
with TastenbelegungDatentypen;
with OptionenVariablen;
with ViewsSFML;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with Eingabe;
with GebaeudeAllgemein;
with EinheitenModifizieren;
with NachGrafiktask;
with NachLogiktask;
with InteraktionAuswahl;
with Vergleiche;
with GrafikEinstellungenSFML;

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

      GebäudeBaubar := MöglicheGebäudeErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      EinheitenBaubar := MöglicheEinheitenErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);

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
   
   
   
   function MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      BauenMöglich := False;
      InteraktionAuswahl.MöglicheGebäude := (others => False);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
                  
         if
           True = GebaeudeAllgemein.GebäudeAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                   IDExtern               => GebäudeSchleifenwert)
         then
            InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := True;
            
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
           True = EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
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
         
         AktuelleAuswahl := MausAuswahl;
         NachGrafiktask.AktuelleBauauswahl := AktuelleAuswahl;
         
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
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      
      return GewähltesBauprojekt;
      
   end AuswahlBauprojektSFML;
   
   
   
   function MausAuswahl
     return StadtRecords.BauprojektRecord
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => ViewsSFML.BauviewAccesse (1));
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         case
           InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenGebäudeBauen (GebäudeSchleifenwert))
               then
                  return (GebäudeSchleifenwert, 0);
         
               else
                  null;
               end if;

            when others =>
               null;
         end case;
         
      end loop GebäudeSchleife;
            
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => ViewsSFML.BauviewAccesse (2));
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           InteraktionAuswahl.MöglicheEinheiten (EinheitenSchleifenwert)
         is
            when True =>
               if
                 True = Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                                    TextboxExtern      => InteraktionAuswahl.PositionenEinheitenBauen (EinheitenSchleifenwert))
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
