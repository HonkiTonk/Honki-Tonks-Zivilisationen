private with Ada.Streams.Stream_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

package LadenLogik is
   pragma Elaborate_Body;

   function Laden
     return Boolean;

private
   use Ada.Streams.Stream_IO;
   use Ada.Strings.Wide_Wide_Unbounded;

   Leerwert : Boolean;
   Zwischenprüfung : Boolean;

   DateiLaden : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;

   procedure Ladevorgang
     (DateiLadenExtern : in File_Type);



   function Prüfen
     (DateiLadenExtern : in File_Type)
      return Boolean;

   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenLogik;
