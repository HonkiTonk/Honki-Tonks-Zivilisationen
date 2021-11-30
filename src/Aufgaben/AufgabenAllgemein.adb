pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with GlobaleTexte;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;

with Anzeige;

package body AufgabenAllgemein is

   procedure Beschreibung
     (KartenVerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      if
        GlobaleVariablen.AnzeigeArt = SystemDatentypen.Konsole
      then
         case
           KartenVerbesserungExtern
         is
            when KartenDatentypen.Leer =>
               null;
            
            when others =>
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Beschreibungen_Verbesserungen_Kurz,
                                                     TextZeileExtern => KartenDatentypen.Karten_Verbesserung_Enum'Pos (KartenVerbesserungExtern));
         end case;
         
      else
         case
           KartenVerbesserungExtern
         is
            when KartenDatentypen.Leer =>
               Sf.Graphics.Text.setUnicodeString (text => TextAccessExtern,
                                                  str  => "");
               
            when others =>
               AktuelleVerbesserung := 2 * KartenDatentypen.Karten_Verbesserung_Enum'Pos (KartenVerbesserungExtern) - 1;
               
               Sf.Graphics.Text.setUnicodeString (text => TextAccessExtern,
                                                  str  => To_Wide_Wide_String (Source => GlobaleTexte.Verbesserungen (AktuelleVerbesserung)));
         end case;
      end if;
      
   end Beschreibung;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => SystemDatentypen.Leer);
      SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                                   RechnenSetzenExtern      => 0);
      SchreibeEinheitenGebaut.BeschäftigungNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        BeschäftigungExtern     => SystemDatentypen.Leer);
      SchreibeEinheitenGebaut.BeschäftigungszeitNachfolger (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             ZeitExtern               => EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger,
                                                             RechnenSetzenExtern      => 0);
      
   end Nullsetzung;

end AufgabenAllgemein;
