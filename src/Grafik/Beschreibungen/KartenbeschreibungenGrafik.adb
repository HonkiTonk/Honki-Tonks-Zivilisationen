with Kartentexte;

-- Später die Beschreibungen noch um SpeziesExtern erweitern damit jede Spezies ihren eigenen Text haben kann? äöü
-- Gilt auch für alle anderen Beschreibungen die noch nicht Speziesspezifisch sind. äöü
package body KartenbeschreibungenGrafik is

   function KurzbeschreibungBasisgrund
     (KartenGrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
   
      return Kartentexte.Basisgrund (2 * KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1);
      
   end KurzbeschreibungBasisgrund;
   
   
   
   function LangbeschreibungBasisgrund
     (KartenGrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
   
      return Kartentexte.Basisgrund (2 * KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (KartenGrundExtern));
      
   end LangbeschreibungBasisgrund;
   


   function KurzbeschreibungZusatzgrund
     (KartenGrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
   
      return Kartentexte.Zusatzgrund (2 * KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (KartenGrundExtern) - 1);
      
   end KurzbeschreibungZusatzgrund;
   


   function LangbeschreibungZusatzgrund
     (KartenGrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
   
      return Kartentexte.Zusatzgrund (2 * KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (KartenGrundExtern));
      
   end LangbeschreibungZusatzgrund;
   
   
   
   function KurzbeschreibungFluss
     (KartenFlussExtern : in KartenfluesseDatentypen.Fluss_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Flüsse (2 * KartenfluesseDatentypen.Fluss_Vorhanden_Enum'Pos (KartenFlussExtern) - 1);
      
   end KurzbeschreibungFluss;
   
   
   
   function LangbeschreibungFluss
     (KartenFlussExtern : in KartenfluesseDatentypen.Fluss_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Flüsse (2 * KartenfluesseDatentypen.Fluss_Vorhanden_Enum'Pos (KartenFlussExtern));
      
   end LangbeschreibungFluss;
   
   
   
   function KurzbeschreibungRessource
     (KartenRessourceExtern : in KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
   
      return Kartentexte.Ressourcen (2 * KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum'Pos (KartenRessourceExtern) - 1);
      
   end KurzbeschreibungRessource;
   
   
   
   function LangbeschreibungRessource
     (KartenRessourceExtern : in KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
   
      return Kartentexte.Ressourcen (2 * KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum'Pos (KartenRessourceExtern));
      
   end LangbeschreibungRessource;
   
   
   
   function KurzbeschreibungFeldeffekte
     (FeldeffekteExtern : in KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Feldeffekte (2 * KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Pos (FeldeffekteExtern) - 1);
      
   end KurzbeschreibungFeldeffekte;
   
   
   
   function LangbeschreibungFeldeffekte
     (FeldeffekteExtern : in KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Feldeffekte (2 * KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Pos (FeldeffekteExtern));
      
   end LangbeschreibungFeldeffekte;

end KartenbeschreibungenGrafik;
