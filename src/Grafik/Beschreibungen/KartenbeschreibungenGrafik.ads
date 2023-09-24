with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartengrundDatentypen;
with KartenextraDatentypen;

package KartenbeschreibungenGrafik is
   pragma Elaborate_Body;

   function KurzbeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungBasisgrund'Result)'Length > 0
               );

   function LangbeschreibungBasisgrund
     (KartenGrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungBasisgrund'Result)'Length > 0
               );

   function KurzbeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungZusatzgrund'Result)'Length > 0
               );

   function LangbeschreibungZusatzgrund
     (KartenGrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungZusatzgrund'Result)'Length > 0
               );

   function KurzbeschreibungFluss
     (KartenFlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungFluss'Result)'Length > 0
               );

   function LangbeschreibungFluss
     (KartenFlussExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungFluss'Result)'Length > 0
               );

   function KurzbeschreibungRessource
     (KartenRessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungRessource'Result)'Length > 0
               );

   function LangbeschreibungRessource
     (KartenRessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungRessource'Result)'Length > 0
               );

   function KurzbeschreibungFeldeffekte
     (FeldeffekteExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungFeldeffekte'Result)'Length > 0
               );

   function LangbeschreibungFeldeffekte
     (FeldeffekteExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungFeldeffekte'Result)'Length > 0
               );

end KartenbeschreibungenGrafik;
