pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with Ada.Calendar; use Ada.Calendar;

with TextKonstanten;
with OptionenVariablen;
-- with SystemDatentypen;

-- with Ladezeiten;
with EinlesenSprache;
with EinlesenText;
with EinlesenTastatur;
with EinlesenDatenbanken;
with SchreibenEinstellungen;
with AuswahlSprache;
with EinlesenTexturen;
with Fehler;
with EinlesenMusik;
with EinlesenSounds;

package body Einlesen is

   -- Ladezeiten später ändern und wieder einbauen, vor allem so dass die Nutzerauswahlzeit nicht berücksichtigt wird.
   -- Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, SystemDatentypen.Anfangswert_Enum) := Clock;
   -- Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, SystemDatentypen.Endwert_Enum) := Clock;
   -- Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Startzeit);
      
   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenDatenbanken.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      EinlesenTexturen.EinlesenTexturen;
      EinlesenMusik.EinlesenMusik;
      EinlesenSounds.EinlesenSounds;
      
   end EinlesenOhneAnzeige;
   
   
   
   -- Die Anzeige wird nur für das Einlesen des Textes benötigt, später mal anpassen?
   procedure EinlesenMitAnzeige
   is begin
      
      if
        OptionenVariablen.NutzerEinstellungen.Sprache = TextKonstanten.LeerUnboundedString
      then
         case
           EinlesenSprache.EinlesenSprache
         is
            when True =>
               SpracheAuswählenSchleife:
               loop
                  
                  GewählteSprache := AuswahlSprache.AuswahlSprache;
                  
                  if
                    GewählteSprache = TextKonstanten.LeerUnboundedString
                  then
                     null;
                     
                  else
                     exit SpracheAuswählenSchleife;
                  end if;
                  
               end loop SpracheAuswählenSchleife;
                  
               OptionenVariablen.NutzerEinstellungen.Sprache := GewählteSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
                  
            when False =>
               Fehler.LogikFehler (FehlermeldungExtern => "Einlesen.EinlesenMitAnzeige - Sprachen wurden nicht gefunden.");
         end case;
               
      else
         null;
      end if;
      
      EinlesenText.EinlesenDateien;
      
   end EinlesenMitAnzeige;

end Einlesen;
