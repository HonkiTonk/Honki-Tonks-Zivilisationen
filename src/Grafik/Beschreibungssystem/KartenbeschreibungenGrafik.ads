with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenzusatzgrundDatentypen;
with KartenrohstoffeDatentypen;
with KarteneffekteDatentypen;
with KartenbasisgrundDatentypen;
with KartenfluesseDatentypen;

private with Kartentexte;

package KartenbeschreibungenGrafik is
   pragma Elaborate_Body;

   function KurzbeschreibungBasisgrund
     (KartenGrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungBasisgrund'Result)'Length > 0
               );

   function LangbeschreibungBasisgrund
     (KartenGrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungBasisgrund'Result)'Length > 0
               );

   function KurzbeschreibungZusatzgrund
     (KartenGrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungZusatzgrund'Result)'Length > 0
               );

   function LangbeschreibungZusatzgrund
     (KartenGrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungZusatzgrund'Result)'Length > 0
               );

   function KurzbeschreibungFluss
     (KartenFlussExtern : in KartenfluesseDatentypen.Fluss_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungFluss'Result)'Length > 0
               );

   function LangbeschreibungFluss
     (KartenFlussExtern : in KartenfluesseDatentypen.Fluss_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungFluss'Result)'Length > 0
               );

   function Rohstoffname
     (KartenRohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => Rohstoffname'Result)'Length > 0
               );

   function Rohstoffinformationen
     (KartenRohstoffeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => Rohstoffinformationen'Result)'Length > 0
               );

   function KurzbeschreibungFeldeffekte
     (FeldeffekteExtern : in KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungFeldeffekte'Result)'Length > 0
               );

   function LangbeschreibungFeldeffekte
     (FeldeffekteExtern : in KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungFeldeffekte'Result)'Length > 0
               );

private

   -- Name, Beschreibung, Vorkommen, Verwendung
   Rohstoffzeilen : constant Positive := Kartentexte.Rohstofftextmultiplikator;
   Rohstoffbenennung : constant Positive := Rohstoffzeilen - 1;
   Rohstoffbeschreibung : constant Positive := Rohstoffbenennung - 1;
   Rohstoffvorkommen : constant Positive := Rohstoffbeschreibung - 1;
   Rohstoffverwendung : constant Natural := Rohstoffvorkommen - 1;

end KartenbeschreibungenGrafik;
