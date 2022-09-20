pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Kartentexte;

-- Später die Beschreibungen noch um RasseExtern erweitern damit jede Rasse ihren eigenen Text haben kann? äöü
-- Gilt auch für alle anderen Beschreibungen die noch nicht rassenspezifisch sind. äöü
-- Aktuell gibt es hier nur eine Kurze, aber keine lange Beschreibung, später mal ändern. äöü
package body KartenbeschreibungenGrafik is

   function BeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Kartenfelder (2 * KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1));
      
   end BeschreibungBasisgrund;
   


   function BeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Kartenfelder (2 * KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1));
      
   end BeschreibungZusatzgrund;
   
   
   
   function BeschreibungFluss
     (KartenFlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Kartenflüsse (2 * KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Pos (KartenFlussExtern) - 1));
      
   end BeschreibungFluss;
   
   
   
   function BeschreibungRessource
     (KartenRessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
   
      return To_Wide_Wide_String (Source => Kartentexte.Kartenressourcen (2 * KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Pos (KartenRessourceExtern) - 1));
      
   end BeschreibungRessource;

end KartenbeschreibungenGrafik;
