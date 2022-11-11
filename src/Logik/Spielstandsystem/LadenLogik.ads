with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen; use RassenDatentypen;

private with SonstigesKonstanten;
private with SpielVariablen;

package LadenLogik is
   pragma Elaborate_Body;

   function Laden
     return Boolean;

private

   VersionsnummerPrüfung : Wide_Wide_String (SonstigesKonstanten.Versionsnummer'Range);

   DateiLaden : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;

   procedure Allgemeines
     (DateiLadenExtern : in File_Type);

   procedure KarteLaden
     (DateiLadenExtern : in File_Type);

   procedure RassenwerteLaden
     (DateiLadenExtern : in File_Type);

   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end LadenLogik;
