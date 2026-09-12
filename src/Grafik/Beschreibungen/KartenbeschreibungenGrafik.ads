with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenzusatzgrundDatentypen;
with KartenressourcenDatentypen;
with KarteneffekteDatentypen;
with KartenbasisgrundDatentypen;
with KartenfluesseDatentypen;

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

   function KurzbeschreibungRessource
     (KartenRessourceExtern : in KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => KurzbeschreibungRessource'Result)'Length > 0
               );

   function LangbeschreibungRessource
     (KartenRessourceExtern : in KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
     with
       Post => (
                  To_Wide_Wide_String (Source => LangbeschreibungRessource'Result)'Length > 0
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

end KartenbeschreibungenGrafik;
