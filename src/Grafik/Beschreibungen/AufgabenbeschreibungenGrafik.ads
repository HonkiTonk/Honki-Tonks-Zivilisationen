with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenverbesserungDatentypen;
with KartenwegeDatentypen;

package AufgabenbeschreibungenGrafik is
   pragma Elaborate_Body;

   function KurzbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungVerbesserung'Result)'Length > 0
               );

   function LangbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungVerbesserung'Result)'Length > 0
               );

   function KurzbeschreibungWeg
     (KartenWegExtern : in KartenwegeDatentypen.Weg_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungWeg'Result)'Length > 0
               );

   function LangbeschreibungWeg
     (KartenWegExtern : in KartenwegeDatentypen.Weg_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungWeg'Result)'Length > 0
               );

end AufgabenbeschreibungenGrafik;
