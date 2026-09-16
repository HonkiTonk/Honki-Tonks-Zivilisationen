with Ada.Exceptions; use Ada.Exceptions;
  
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with LeseWeltkarte;

package body SpeichernBasisgrundLogik is
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      -- Man kann das teilweise zusammenfassen, aber mal getrennt lassen für spätere, potentielle Verbesserungen.
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.OrbitKonstante | KartenKonstanten.HimmelKonstante =>
            null;
            
         when KartenKonstanten.OberflächeKonstante =>
            KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
            
         when KartenKonstanten.UnterflächeKonstante =>
            KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
            
         when KartenKonstanten.KernKonstante =>
            KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKartenbelegungLogik.Basisgrund: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Basisgrund;

end SpeichernBasisgrundLogik;
